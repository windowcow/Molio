protocol SpotifyRepository {
    func fetchRecommendedSongsISRC(musicFilter: MusicFilter) async -> [String]
}
