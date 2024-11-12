import Foundation
import Combine

protocol MusicDeck {
    // @Published의 고질적인 문제: 프로토콜 요구사항에 프로퍼티 레퍼를 강제할 수가 없다.
    // 따라서 일단 Current Value Subject로 하겠다.
    func getPublisherForMusicFromDeck(at: Int) -> AnyPublisher<RandomMusic?, Never>
}

final class RandomMusicDeck: MusicDeck {
    // MARK: 의존성 주입
    
    private var fetchMusicsUseCase: any FetchMusicsUseCase
    private var musicFilterProvider: any MusicFilterProvider
    
    private var randomMusics = CurrentValueSubject<[RandomMusic], Never>([])
    private var musicFilter: MusicFilter?
    
    // MARK: Combine
    
    private var deckReloadSubscription: AnyCancellable? = nil
    private var musicFilterSubscription: AnyCancellable? = nil

    // MARK: 생성자
    
    init(fetchMusicsUseCase: any FetchMusicsUseCase, musicFilterProvider: any MusicFilterProvider) {
        self.fetchMusicsUseCase = fetchMusicsUseCase
        self.musicFilterProvider = musicFilterProvider
    }
    
    // MARK: 구독
    
    // Sink에서 하는 행동을 위주로 이름지었다.
    private func setUpDeckReloadSubscription() {
        self.deckReloadSubscription = self.randomMusics.sink { randomMusic in
            if randomMusic.count < 10 {
                Task { [weak self] in
                    guard let self else { return }
                    
                    guard let musicFilter = self.musicFilter else { return }
                    
                    guard let fetchedMusics = try? await fetchMusicsUseCase.execute(genres: musicFilter.genres) else { return }
                    
                    randomMusics.value.append(contentsOf: fetchedMusics)
                }
            }
        }
    }
    
    private func setUpMusicFilterSubscription() {
        self.musicFilterSubscription = musicFilterProvider.getMusicFilterPublisher()
            .removeDuplicates(by: { m1, m2 in
                m1.genres == m2.genres
            })
            .sink { [weak self] musicFilter in
                self?.musicFilter = musicFilter
            }
    }
    
    func getPublisherForMusicFromDeck(at index: Int) -> AnyPublisher<RandomMusic?, Never> {
        randomMusics
            .compactMap({ randomMusics in
                guard randomMusics.count > index else { return nil }
                
                return randomMusics[index]
            })
            .removeDuplicates { (previousMusicAtTheIndex: RandomMusic?, newMusicAtTheIndex: RandomMusic?) in
                previousMusicAtTheIndex?.isrc == newMusicAtTheIndex?.isrc
            }
            .eraseToAnyPublisher()
    }
}

protocol MusicFilterProvider {
    func getMusicFilterPublisher() -> AnyPublisher<MusicFilter, Never>
}
