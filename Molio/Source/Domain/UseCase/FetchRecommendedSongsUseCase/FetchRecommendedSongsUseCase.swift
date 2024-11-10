protocol FetchRecommendedSongsUseCase {
    func execute(musicFilter: MusicFilter) async throws -> [String]
}

final class DefaultFetchRecommendedSongsUseCase: FetchRecommendedSongsUseCase {
    private let spotifyRepository: SpotifyRepository
    
    init(spotifyRepository: SpotifyRepository = MockSpotifyRepository()) {
        self.spotifyRepository = spotifyRepository
    }
    
    // 노래 필터를 기반으로 추천 노래 ISRC 배열을 비동기로 가져온다.
    func execute(musicFilter: MusicFilter) async throws -> [String] {
        return try await spotifyRepository.fetchRecommendedSongsISRC(musicFilter: musicFilter)
    }
}
