protocol SpotifyTokenProvider {
    func getAccessToken() async throws -> String
}
