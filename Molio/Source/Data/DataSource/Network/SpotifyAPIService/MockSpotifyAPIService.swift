struct MockSpotifyAPIService: SpotifyAPIService {
    var isrcsToReturn: [String] = []
    
    func fetchRecommendedMusicISRCs(musicFilter: MusicFilter) async throws -> [String] {
        return isrcsToReturn
    }
}
