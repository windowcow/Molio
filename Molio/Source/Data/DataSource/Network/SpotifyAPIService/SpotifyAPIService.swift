protocol SpotifyAPIService {
    var spotifyAccessTokenProvider: SpotifyAccessTokenProvider { get }
    
    func fetchRecommendedMusicISRCs(musicFilterEntity: MusicFilter) async -> [String]
}
