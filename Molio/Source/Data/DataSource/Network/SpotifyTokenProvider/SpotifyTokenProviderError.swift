import Foundation

enum SpotifyTokenProviderError: LocalizedError {
    case failedToCreateToken
    
    var errorDescription: String? {
        switch self {
        case .failedToCreateToken: "토큰을 새로 불러오지 못했습니다."
        }
    }
}
