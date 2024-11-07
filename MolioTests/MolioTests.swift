import XCTest
@testable import Molio

final class FetchRecommendedMusicTests: XCTestCase {
    func testMusicRecommendation() async {
        let fetchRecommendedSongsUseCase = FetchRecommendedSongsUseCase()
        let genres = ["k-pop"]
        
        let musicFilter = MusicFilterEntity(genres: genres)
        
        let fetchedISRCs = await fetchRecommendedSongsUseCase.execute(musicFilter: musicFilter)
        
        print(fetchedISRCs)
    }
}
