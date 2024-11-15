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
        return 170.0
    }
    
    private let fetchImageUseCase: FetchImageUseCase
    private let isLoadingPublisher = PassthroughSubject<Bool, Never>()
    private let buttonHighlightPublisher = PassthroughSubject<ButtonHighlight, Never>()
    private let musicCardSwipeAnimationPublisher = PassthroughSubject<SwipeDirection, Never>()
    private let errorPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Music Deck
    
    let musicDeck: any MusicDeck
    
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
                    print("like")
                    return .right
                } else if translation < -self.swipeThreshold {
                    // TODO: 노래 싫어요에 대한 처리 추가하기
                    print("dislike")
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
            // 버튼이 눌릴 때마다 send가 되는 것이 아니라 구독이 생성되고 있습니다.
            .sink { [weak self] _ in
                guard let self else { return }
                // TODO: 노래 싫어요 대한 처리 추가하기
                self.musicCardSwipeAnimationPublisher.send(.left)
            }
            .store(in: &cancellables)

        return Output(
            isLoading: isLoadingPublisher.eraseToAnyPublisher(),
            buttonHighlight: buttonHighlightPublisher.eraseToAnyPublisher(),
            musicCardSwipeAnimation: musicCardSwipeAnimationPublisher.eraseToAnyPublisher(),
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
    
    func likeCurrentMusic() {
        musicDeck.likeCurrentMusic()
    }
    
    func dislikeCurrentMusic() {
        musicDeck.dislikeCurrentMusic()
    }
}
