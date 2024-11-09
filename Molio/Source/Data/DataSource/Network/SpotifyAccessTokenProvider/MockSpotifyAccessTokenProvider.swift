struct MockSpotifyAccessTokenProvider: SpotifyAccessTokenProvider {
    private var accessToken: String = ""
    
    func getAccessToken() async -> String {
        if await isValid(token: accessToken) {
            return accessToken
        }
        
        return await fetchNewAccessToken()
    }
    
    /// 만료 시간을 통해 토큰 유효성을 검사
    private func isValid(token: String) async -> Bool {
        return true
    }
    
    private func fetchNewAccessToken() async -> String {
        return ""
    }
}
