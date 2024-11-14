import Foundation
import Combine
import MusicKit

final class SwipeMusicViewModel: InputOutputViewModel {
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let isLoading: AnyPublisher<Bool, Never> // TODO: 로딩 UI 구현 및 연결
        let error: AnyPublisher<String, Never> // TODO: Error에 따른 알림 UI 구현 및 연결
    }
    
    private let musicPlayer = SwipeMusicPlayer()
    private let fetchImageUseCase: FetchImageUseCase
    private let isLoadingPublisher = PassthroughSubject<Bool, Never>()
    private let errorPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Music Deck
    
    private let musicDeck: any MusicDeck
    
    let currentMusicTrackPublisher = CurrentValueSubject<SwipeMusicTrackModel?, Never>(nil)
    let nextMusicTrackPublisher = CurrentValueSubject<SwipeMusicTrackModel?, Never>(nil)

    init(
        fetchMusicsUseCase: FetchMusicsUseCase,
        fetchImageUseCase: FetchImageUseCase,
        musicFilterProvider: any MusicFilterProvider
    ) {
        self.musicDeck = RandomMusicDeck(fetchMusicsUseCase: fetchMusicsUseCase, musicFilterProvider: musicFilterProvider)
        self.fetchImageUseCase = fetchImageUseCase
        setupBindings()
    }
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoadingPublisher.send(true)
            })
            .sink { [weak self] musics in
                self?.isLoadingPublisher.send(false)
            }
            .store(in: &cancellables)
        
        return Output(
            isLoading: isLoadingPublisher.eraseToAnyPublisher(),
            error: errorPublisher.eraseToAnyPublisher()
        )
    }
    
    private func setupBindings() {
        
        // MARK: 현재 노래 관련
        // currentMusicTrack이 변경되면 sink에 정의된 동작을 실행한다.
        musicDeck.currentMusicTrackModelPublisher
            .sink { [weak self] currentMusic in
                guard let currentMusic else {
                    // TODO: 현재 노래가 없는 경우 보여줄 카드를 여기에 담아야 함
                    return
                }
                
                Task { [weak self] in
                    do {
                        let swipeMusicTrackModel = try await self?.loadMusicCard(from: currentMusic)
                        
                        self?.currentMusicTrackPublisher.send(swipeMusicTrackModel)
                    } catch {
                        self?.errorPublisher.send("재생할 노래가 없습니다.")
                    }
                }
            }
            .store(in: &cancellables)
        
        
         // MARK: 다음 노래 관련
        
        musicDeck.nextMusicTrackModelPublisher
            .sink { [weak self] nextMusic in
                guard let nextMusic else {
                    // TODO: 현재 노래가 없는 경우 보여줄 카드를 여기에 담아야 함
                    return
                }
                
                Task { [weak self] in
                    do {
                        let swipeMusicTrackModel = try await self?.loadMusicCard(from: nextMusic)
                        
                        self?.nextMusicTrackPublisher.send(swipeMusicTrackModel)
                    } catch {
                        self?.errorPublisher.send("다음 노래가 없습니다.")
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func loadMusicCard(from music: RandomMusic) async throws -> SwipeMusicTrackModel {
        guard let imageURL = music.artworkImageURL else {
            return SwipeMusicTrackModel(randomMusic: music, imageData: nil)
        }
        
        let imageData = try await fetchImageUseCase.execute(url: imageURL)

        return SwipeMusicTrackModel(randomMusic: music, imageData: imageData)
    }
    
    func loadAndPlaySongs(urls: [URL]) {
        musicPlayer.loadSongs(with: urls)
        musicPlayer.play()
    }
    
    func nextSong() {
        musicDeck.likeCurrentMusic()
        
        // TODO: 반복 실행
    }
}
