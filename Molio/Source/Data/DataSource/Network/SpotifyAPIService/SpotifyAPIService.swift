protocol SpotifyAPIService {
    func fetchRecommendedMusicISRCs(musicFilter: MusicFilter) async throws -> [String]
}
