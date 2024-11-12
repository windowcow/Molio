final class DefaultSpotifyAPIService: SpotifyAPIService {
    private let networkProvider: NetworkProvider
    private let tokenProvider: SpotifyTokenProvider
    
    init(networkProvider: NetworkProvider, tokenProvider: SpotifyTokenProvider) {
        self.networkProvider = networkProvider
        self.tokenProvider = tokenProvider
    }
    
    func fetchRecommendedMusicISRCs(musicFilter: MusicFilter) async throws -> [String] {
        // TODO: - TokenProvider로부터 토큰값 받도록 수정
        let dto: RecommendationsResponseDTO = try await networkProvider.request(SpotifyAPI.getRecommendations(genres: musicFilter.genres))
        return dto.tracks.map(\.externalIDs.isrc)
    }
}
