struct MockSpotifyRepository: SpotifyRepository {
    var spotifyAPIService: SpotifyAPIService
    
    init(spotifyAPIService: SpotifyAPIService = MockSpotifyAPIService()) {
        self.spotifyAPIService = spotifyAPIService
    }
    
    func fetchRecommendedSongsISRC(musicFilter: MusicFilter) async throws -> [String] {
        return try await spotifyAPIService.fetchRecommendedMusicISRCs(musicFilter: musicFilter)
    }
}
