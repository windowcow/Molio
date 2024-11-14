final class DefaultSpotifyAPIService: SpotifyAPIService {
    private let networkProvider: NetworkProvider
    private let tokenProvider: SpotifyTokenProvider
    
    init(networkProvider: NetworkProvider, tokenProvider: SpotifyTokenProvider) {
        self.networkProvider = networkProvider
        self.tokenProvider = tokenProvider
    }
    
    func fetchRecommendedMusicISRCs(musicFilter: MusicFilter) async throws -> [String] {
        let accessToken = try await tokenProvider.getAccessToken()
        let endPoint = SpotifyAPI.getRecommendations(genres: musicFilter.genres, accessToken: accessToken)
        let dto: RecommendationsResponseDTO = try await networkProvider.request(endPoint)
        return dto.tracks.map(\.externalIDs.isrc)
    }
}
