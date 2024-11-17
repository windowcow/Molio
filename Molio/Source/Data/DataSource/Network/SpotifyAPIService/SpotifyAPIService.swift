protocol SpotifyAPIService {
    func fetchRecommendedMusicISRCs(musicFilter: MusicFilter) async throws -> [String]
    func fetchAvailableGenreSeeds() async throws -> SpotifyAvailableGenreSeedsDTO
}
