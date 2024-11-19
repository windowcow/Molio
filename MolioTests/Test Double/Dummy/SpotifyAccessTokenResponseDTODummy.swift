import Foundation
@testable import Molio

extension SpotifyAccessTokenResponseDTO: Swift.Equatable {
    public static func == (lhs: SpotifyAccessTokenResponseDTO, rhs: SpotifyAccessTokenResponseDTO) -> Bool {
        let isAccessTokenEqual = lhs.accessToken == rhs.accessToken
        let isTokenTypeEqual = lhs.tokenType == rhs.tokenType
        let isExpiredInEqual = lhs.expiresIn == rhs.expiresIn
        
        return isAccessTokenEqual && isTokenTypeEqual && isExpiredInEqual
    }
}

extension SpotifyAccessTokenResponseDTO {
    static let dummyData: Data =
    #"""
    {
        "access_token": "BQB6u7vBjWYPp3zHwRwV9Nmb9MC280UBk2poWgeSuOYmScPmlMiEeENy3oG6sB2Dy2_jsPeSjmhI5fnKXe5EMoc0XLNQ_2cyIpH_GnLEdadMroAIw2c",
        "token_type": "Bearer",
        "expires_in": 3600
    }
    """#.data(using: .utf8)!
}
