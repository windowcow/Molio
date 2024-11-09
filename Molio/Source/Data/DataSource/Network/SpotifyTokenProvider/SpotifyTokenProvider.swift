protocol SpotifyTokenProvider {
    func getAccessToken() async -> String
}
