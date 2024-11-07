struct MockSpotifyAccessTokenProvider: SpotifyAccessTokenProvider {
    // 이 부분은 바꾸지 말기, 시작 값이 ""이다
    private var accessToken: String = ""
    
    func getAccessToken() async -> String {
        if await isValid(token: accessToken) {
            return accessToken
        }
        
        return await fetchNewAccessToken()
    }
    
    private func isValid(token: String) async -> Bool {
        // 서버에서 토큰이 유효하지 검증하거나 만료 시간으로 검증하는 로직 작성
        
        return true
    }
    
    private func fetchNewAccessToken() async -> String {
        // 서버에서 토큰을 받아오는 로직
        return ""
    }
}
