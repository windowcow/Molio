protocol SpotifyAPIService {
    var spotifyAccessTokenProvider: SpotifyAccessTokenProvider { get }
    
    func fetchRecommendedMusicISRCs(musicFilterEntity: MusicFilterEntity) async -> [String]
}
