struct MockSpotifyRepository: SpotifyRepository {
    var spotifyAPIService: SpotifyAPIService
    
    init(spotifyAPIService: SpotifyAPIService = MockSpotifyAPIService()) {
        self.spotifyAPIService = spotifyAPIService
    }
    
    func fetchRecommendedSongsISRC(musicFilter: MusicFilter) async -> [String] {
        return await spotifyAPIService.fetchRecommendedMusicISRCs(musicFilter: musicFilter)
    }
}
