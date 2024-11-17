import XCTest
@testable import Molio

final class DeckTests: XCTestCase {
    private var deck: RandomMusicDeck = {
        let networkProvider = DefaultNetworkProvider()
        
        let spotifyTokenProvider = MockSpotifyTokenProvider()
        
        let spotifyAPIService = DefaultSpotifyAPIService(networkProvider: networkProvider, tokenProvider: spotifyTokenProvider)
        
        let musicKitService = DefaultMusicKitService()
        
        let repository = DefaultRecommendedMusicRepository(spotifyAPIService: spotifyAPIService, musicKitService: musicKitService)
        
        let fetchMusicUseCase = DefaultFetchRecommendedMusicUseCase(repository: repository)
        
        let musicFilterProvider = MockMusicFilterProvider()
        
        return RandomMusicDeck(fetchMusicsUseCase: fetchMusicUseCase, musicFilterProvider: musicFilterProvider)
    }()
    
    func testDeckFetch() async {
        let subscription = deck.randomMusics.sink { randomMusics in
            print(randomMusics)
        }
        
        Thread.sleep(forTimeInterval: 30)
    }
    
    func testDeckSwipe() {
        Thread.sleep(forTimeInterval: 1)
        
        let subscription = deck.randomMusics
            .sink { randomMusics in
                print("노래 5곡:", randomMusics.prefix(5).map { $0.title }.joined(separator: ", "))
            }
        
        let currentMusicPublisher = deck.currentMusicTrackModelPublisher
        let nextMusicPublisher = deck.nextMusicTrackModelPublisher
        
        let currentMusicSubscription = currentMusicPublisher
            .sink { music in
                print("현재 노래:", music?.title ?? "비어있습니다.")
            }

        let nextMusicSubscription = nextMusicPublisher
            .sink { music in
                print("다음 노래:", music?.title ?? "비어있습니다.")
            }

        for i in 0 ..< 50 {
            Thread.sleep(forTimeInterval: 1)

            deck.likeCurrentMusic()
        }
    }
}
