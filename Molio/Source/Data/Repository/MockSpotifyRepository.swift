struct MockSpotifyRepository: SpotifyRepository {
    var spotifyAPIService: SpotifyAPIService
    
    init(spotifyAPIService: SpotifyAPIService = MockSpotifyAPIService()) {
        self.spotifyAPIService = spotifyAPIService
    }
    
    func fetchRecommendedSong(musicFilter: MusicFilter) async -> [String] {
        return await spotifyAPIService.fetchRecommendedMusicISRCs(musicFilterEntity: musicFilter)
    }
}
