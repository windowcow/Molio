// 카드 추천 덱의 ViewModel에서 사용할 노래 추천 유즈케이스
final class FetchRecommendedSongsUseCase {
    let spotifyRepository: SpotifyRepository
    
    init(spotifyRepository: SpotifyRepository = MockSpotifyRepository()) {
        self.spotifyRepository = spotifyRepository
    }
    
    // 노래 필터를 기반으로 추천 노래 ISRC 배열을 비동기로 가져온다.
    func execute(musicFilter: MusicFilterEntity) async -> [String] {
        await spotifyRepository.fetchRecommendedSong(musicFilter: musicFilter)
    }
}
