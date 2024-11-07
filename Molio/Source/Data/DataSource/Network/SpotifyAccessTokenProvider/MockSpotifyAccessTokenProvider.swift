struct MockSpotifyAccessTokenProvider: SpotifyAccessTokenProvider {
    func getAccessToken() async -> String {
        // 여기에 토큰을 넣어서 테스트할 수 있습니다.
        return ""
    }
}
