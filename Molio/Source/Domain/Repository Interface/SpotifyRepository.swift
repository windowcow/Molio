protocol SpotifyRepository {
    var spotifyAPIService: SpotifyAPIService { get }
    // ISRC 배열을 반환한다.
    func fetchRecommendedSong(musicFilter: MusicFilterEntity) async -> [String]
}
