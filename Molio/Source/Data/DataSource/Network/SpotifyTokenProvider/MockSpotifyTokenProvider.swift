struct MockSpotifyTokenProvider: SpotifyTokenProvider {
    var accessTokenToReturn: String = ""
    var isValid: Bool = true
    
    func getAccessToken() async throws -> String {
        if isValid {
            return accessTokenToReturn
        } else {
            throw NetworkError.requestFail(code: .badRequest)
        }
    }
}
