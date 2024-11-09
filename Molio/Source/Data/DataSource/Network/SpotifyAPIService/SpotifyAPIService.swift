protocol SpotifyAPIService {
    func fetchRecommendedMusicISRCs(musicFilterEntity: MusicFilter) async -> [String]
}
