protocol SpotifyRepository {
    func fetchRecommendedSongsISRC(musicFilter: MusicFilter) async throws -> [String]
}
