import Foundation
import Combine
import MusicKit

final class SwipeMusicViewModel: InputOutputViewModel {
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let musicCardDidChangeSwipe: AnyPublisher<CGFloat, Never>
        let musicCardDidFinishSwipe: AnyPublisher<CGFloat, Never>
        let likeButtonDidTap: AnyPublisher<Void, Never>
        let dislikeButtonDidTap: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let currentMusicTrack: AnyPublisher<SwipeMusicTrackModel, Never>
        let isLoading: AnyPublisher<Bool, Never> // TODO: 로딩 UI 구현 및 연결
        let buttonHighlight: AnyPublisher<ButtonHighlight, Never>
        let musicCardSwipeAnimation: AnyPublisher<SwipeDirection, Never>
        let error: AnyPublisher<String, Never> // TODO: Error에 따른 알림 UI 구현 및 연결
    }
    
    enum SwipeDirection: CGFloat {
        case left = -1.0
        case right = 1.0
        case none = 0
    }
    
    struct ButtonHighlight {
        let isLikeHighlighted: Bool
        let isDislikeHighlighted: Bool
    }
    
    var swipeThreshold: CGFloat {
        return 200.0
    }
    
    private let musicPlayer = SwipeMusicPlayer()
    private let fetchMusicsUseCase: FetchMusicsUseCase
    private let fetchImageUseCase: FetchImageUseCase
    private var musicsSubject = CurrentValueSubject<[RandomMusic], Never>([])
    private let currentMusicCardPublisher = PassthroughSubject<SwipeMusicTrackModel, Never>()
    private let isLoadingPublisher = PassthroughSubject<Bool, Never>()
    private let buttonHighlightPublisher = PassthroughSubject<ButtonHighlight, Never>()
    private let musicCardSwipeAnimationPublisher = PassthroughSubject<SwipeDirection, Never>()
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
        
        input.musicCardDidChangeSwipe
            .map { [weak self] translation -> ButtonHighlight in
                guard let self else {
                    return ButtonHighlight(isLikeHighlighted: false, isDislikeHighlighted: false)
                }
                return ButtonHighlight(isLikeHighlighted: translation > self.swipeThreshold,
                                       isDislikeHighlighted: translation < -self.swipeThreshold
                )
            }
            .sink { [weak self] buttonHighlight in
                self?.buttonHighlightPublisher.send(buttonHighlight)
            }
            .store(in: &cancellables)
        
        input.musicCardDidFinishSwipe
            .map { [weak self] translation -> SwipeDirection in
                guard let self else { return .none }
                if translation > self.swipeThreshold {
                    // TODO: 노래 좋아요에 대한 처리 추가하기
                    return .right
                } else if translation < -self.swipeThreshold {
                    // TODO: 노래 싫어요에 대한 처리 추가하기
                    return .left
                } else {
                    return .none
                }
            }
            .sink { [weak self] swipeDirection in
                guard let self else { return }
                self.musicCardSwipeAnimationPublisher.send(swipeDirection)
                self.buttonHighlightPublisher.send(
                    ButtonHighlight(isLikeHighlighted: false,
                                    isDislikeHighlighted: false)
                )
            }
            .store(in: &cancellables)
        
        input.likeButtonDidTap
            .sink { [weak self] _ in
                guard let self else { return }
                // TODO: 노래 좋아요에 대한 처리 추가하기
                self.musicCardSwipeAnimationPublisher.send(.right)
            }
            .store(in: &cancellables)
        
        input.dislikeButtonDidTap
            .sink { [weak self] _ in
                guard let self else { return }
                // TODO: 노래 싫어요 대한 처리 추가하기
                self.musicCardSwipeAnimationPublisher.send(.left)
            }
            .store(in: &cancellables)
        
        return Output(currentMusicTrack: currentMusicCardPublisher.eraseToAnyPublisher(),
                      isLoading: isLoadingPublisher.eraseToAnyPublisher(),
                      buttonHighlight: buttonHighlightPublisher.eraseToAnyPublisher(),
                      musicCardSwipeAnimation: musicCardSwipeAnimationPublisher.eraseToAnyPublisher(),
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
                    self?.loadAndPlaySongs(urls: [firstMusic.previewAsset]) // TODO: 임시 노래 재생 이후 수정
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
