protocol SpotifyAPIService {
    func fetchRecommendedMusicISRCs(with filter: MusicFilter) async throws -> [String]
    func fetchAvailableGenreSeeds() async throws -> SpotifyAvailableGenreSeedsDTO
}
