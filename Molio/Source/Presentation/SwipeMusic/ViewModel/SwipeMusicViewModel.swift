import Foundation
import Combine
import MusicKit

final class SwipeMusicViewModel: InputOutputViewModel {
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let currentMusicTrack: AnyPublisher<SwipeMusicTrackModel, Never>
        let isLoading: AnyPublisher<Bool, Never> // TODO: 로딩 UI 구현 및 연결
        let error: AnyPublisher<String, Never> // TODO: Error에 따른 알림 UI 구현 및 연결
    }
    private let musicPlayer = SwipeMusicPlayer()
    
    private let fetchMusicsUseCase: FetchMusicsUseCase
    private let fetchImageUseCase: FetchImageUseCase
    private var musicsSubject = CurrentValueSubject<[RandomMusic], Never>([])
    private let currentMusicCardPublisher = PassthroughSubject<SwipeMusicTrackModel, Never>()
    private let isLoadingPublisher = PassthroughSubject<Bool, Never>()
    private let errorPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchMusicsUseCase: FetchMusicsUseCase, fetchImageUseCase: FetchImageUseCase) {
        self.fetchMusicsUseCase = fetchMusicsUseCase
        self.fetchImageUseCase = fetchImageUseCase
        setupBindings()
    }
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoadingPublisher.send(true)
            })
            .flatMap { [weak self] _ -> AnyPublisher<[RandomMusic], Never> in
                guard let self else { return Just([]).eraseToAnyPublisher() }
                return self.fetchMusics()
            }
            .sink { [weak self] musics in
                self?.isLoadingPublisher.send(false)
                self?.musicsSubject.send(musics)
            }
            .store(in: &cancellables)
        
        return Output(currentMusicTrack: currentMusicCardPublisher.eraseToAnyPublisher(),
                      isLoading: isLoadingPublisher.eraseToAnyPublisher(),
                      error: errorPublisher.eraseToAnyPublisher()
        )
    }
    
    private func fetchMusics() -> AnyPublisher<[RandomMusic], Never> {
        Future { [weak self] promise in
            guard let self else { return promise(.success([])) }
            Task {
                do {
                    let musics = try await self.fetchMusicsUseCase.execute(genres: ["k-pop"])
                    promise(.success(musics))
                } catch {
                    promise(.success([]))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func setupBindings() {
        musicsSubject
            .sink { [weak self] musics in
                if musics.isEmpty {
                    self?.errorPublisher.send("재생 가능한 음악이 없습니다.")
                } else if let firstMusic = musics.first {
                    self?.loadMusicCard(from: firstMusic)
                }
            }
            .store(in: &cancellables)
    }
    
    private func loadMusicCard(from music: RandomMusic) {
        guard let imageURL = music.artworkImageURL else {
            currentMusicCardPublisher.send(SwipeMusicTrackModel(randomMusic: music, imageData: nil))
            return
        }
        
        Task {
            do {
                let imageData = try await fetchImageUseCase.execute(url: imageURL)
                currentMusicCardPublisher.send(SwipeMusicTrackModel(randomMusic: music, imageData: imageData))
            } catch {
                currentMusicCardPublisher.send(SwipeMusicTrackModel(randomMusic: music, imageData: nil))
            }
        }
    }
    
    func loadAndPlaySongs(urls: [URL]) {
        musicPlayer.loadSongs(with: urls)
        musicPlayer.play()
    }
    
    func nextSong() {
        musicPlayer.playNext()
    }
}
