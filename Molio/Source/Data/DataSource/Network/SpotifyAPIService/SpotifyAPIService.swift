protocol SpotifyAPIService {
    func fetchRecommendedMusicISRCs(musicFilter: MusicFilter) async -> [String]
}
