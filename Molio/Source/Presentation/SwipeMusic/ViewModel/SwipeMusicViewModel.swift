import Foundation
import Combine
import MusicKit

final class SwipeMusicViewModel: InputOutputViewModel {
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let currentMusicTrack: AnyPublisher<RandomMusic, Never>
        let isLoading: AnyPublisher<Bool, Never>
        let error: AnyPublisher<String, Never>
    }
    
    private let fetchMusicsUseCase: FetchMusicsUseCase
    private var musics: [RandomMusic] = []
    private let currentMusicCardPublisher = PassthroughSubject<RandomMusic, Never>()
    private let isLoadingPublisher = PassthroughSubject<Bool, Never>()
    private let errorPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchMusicsUseCase: FetchMusicsUseCase) {
        self.fetchMusicsUseCase = fetchMusicsUseCase
    }
    
    func transform(from input: Input) -> Output {
        input.viewDidLoad
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoadingPublisher.send(true)
            })
            .flatMap { [weak self] _ -> AnyPublisher<[RandomMusic], Never> in
                guard let self else {
                    return Just([]).eraseToAnyPublisher()
                }
                return Future<[RandomMusic], Error> { promise in
                    Task {
                        do {
                            let musics = try await self.fetchMusicsUseCase.execute(genres: ["k-pop"])
                            promise(.success(musics))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { _ -> AnyPublisher<[RandomMusic], Never> in
                    return Just([]).eraseToAnyPublisher()
                }.eraseToAnyPublisher()
            }
            .sink { [weak self] musics in
                guard let self else { return }
                self.isLoadingPublisher.send(false)
                self.musics = musics
                
                if let firstMusic = musics.first {
                    self.currentMusicCardPublisher.send(limitGenres(for: firstMusic))
                } else {
                    self.errorPublisher.send("재생 가능한 음악이 없습니다.")
                }
            }
            .store(in: &cancellables)
        
        return Output(currentMusicTrack: currentMusicCardPublisher.eraseToAnyPublisher(),
                      isLoading: isLoadingPublisher.eraseToAnyPublisher(),
                      error: errorPublisher.eraseToAnyPublisher()
        )
    }
    
    private func limitGenres(for music: RandomMusic) -> RandomMusic {
        return RandomMusic(
            title: music.title,
            artistName: music.artistName,
            gerneNames: Array(music.gerneNames.prefix(4)),
            isrc: music.isrc,
            previewAsset: music.previewAsset,
            artworkImageURL: music.artworkImageURL,
            artworkBackgroundColor: music.artworkBackgroundColor,
            primaryTextColor: music.primaryTextColor
        )
    }
}
