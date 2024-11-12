import Foundation
import Combine

protocol MusicDeck {
    // @Published의 고질적인 문제: 프로토콜 요구사항에 프로퍼티 레퍼를 강제할 수가 없다.
    // 따라서 일단 Current Value Subject로 하겠다.
    func getPublisherForMusicFromDeck(at: Int) -> AnyPublisher<RandomMusic?, Never>
    
    func swipeCurrentMusicRight()
    
    func swipeCurrentMusicLeft()
}

final class RandomMusicDeck: MusicDeck {
    // MARK: 의존성 주입
    
    private var fetchMusicsUseCase: any FetchMusicsUseCase
    private var musicFilterProvider: any MusicFilterProvider
    
    // MARK: 생성자에서 초기화
    
    var randomMusics: CurrentValueSubject<[RandomMusic], Never>
    private var musicFilter: CurrentValueSubject<MusicFilter?, Never>
    
    // MARK: Combine
    
    private var deckReloadSubscription: AnyCancellable?
    private var musicFilterSubscription: AnyCancellable?

    // MARK: 생성자
    
    init(fetchMusicsUseCase: any FetchMusicsUseCase, musicFilterProvider: any MusicFilterProvider) {
        // 의존성 주입
        self.fetchMusicsUseCase = fetchMusicsUseCase
        self.musicFilterProvider = musicFilterProvider
        
        // 생성자에서 초기화
        self.randomMusics = CurrentValueSubject([])
        self.musicFilter = CurrentValueSubject(nil)
        
        setUpDeckReloadSubscription()
        setUpMusicFilterSubscription()
    }
    
    // MARK: 구독
    
    // Sink에서 하는 행동을 위주로 이름지었다.
    private func setUpDeckReloadSubscription() {
        self.deckReloadSubscription = self.randomMusics.sink { randomMusic in
            if randomMusic.count < 10 {
                self.loadRandomMusics()
            }
        }
    }
    
    // 필터 프로바이더의 필터가 변경되는 경우 deck에서도 필터를 바꾼다.
    // 이렇게 하지 않는 경우 Deck 외부에서 일어나는 musicFilter의 변경에 대해 대응하기 어렵다.
    // 반응형의 이유
    private func setUpMusicFilterSubscription() {
        self.musicFilterSubscription = musicFilterProvider.getMusicFilterPublisher()
            .removeDuplicates(by: { musicFilterBefore, musicFilterAfter in
                musicFilterBefore.genres == musicFilterAfter.genres
            })
            .sink { musicFilter in
                self.musicFilter.value = musicFilter
                self.loadRandomMusics()
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
    
    private func loadRandomMusics() {
        let genres = self.musicFilter.value?.genres ?? []
        
        Task { [weak self] in
            let fetchedMusics = try? await self?.fetchMusicsUseCase.execute(genres: genres)
            
            guard let fetchedMusics else { return }
            
            self?.randomMusics.value.append(contentsOf: fetchedMusics)
        }
    }
    
    func swipeCurrentMusicRight() {
        removeCurrentMusicCard()
        // 현재 노래에 대한 좋아요 로직
    }
    
    func swipeCurrentMusicLeft() {
        removeCurrentMusicCard()
        // 현재 노래에 대한 싫어요 로직
    }
    
    private func removeCurrentMusicCard() {
        guard !randomMusics.value.isEmpty else { return }
        
        randomMusics.value.remove(at: 0)
    }
}

protocol MusicFilterProvider {
    func getMusicFilterPublisher() -> AnyPublisher<MusicFilter, Never>
}

struct MockMusicFilterProvider: MusicFilterProvider {
    func getMusicFilterPublisher() -> AnyPublisher<MusicFilter, Never> {
        let musicFilter = MusicFilter(genres: ["k-pop"])
        
        return Just(musicFilter).eraseToAnyPublisher()
    }
}
