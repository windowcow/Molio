import Foundation

enum SpotifyAuthorizationAPI {
    case createAccessToken
    
    var description: String {
        switch self {
        case .createAccessToken: "access token 요청 엔드포인트"
        }
    }
}

extension SpotifyAuthorizationAPI: EndPoint {
    var base: String {
        "https://accounts.spotify.com"
    }
    
    var path: String {
        switch self {
        case .createAccessToken: "/api/token"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .createAccessToken: .post
        }
    }
    
    var headers: [String: String]? {
        return [
            Header.Authorization.field: Header.Authorization.value,
            Header.ContentType.field: Header.ContentType.value
        ]
    }
    
    var body: Data? {
        switch self {
        case .createAccessToken: nil
        }
    }
    
    var params: [String: String] {
        switch self {
        case .createAccessToken:
            return ["grant_type": "client_credentials"]
        }
    }
}

private extension SpotifyAuthorizationAPI {
    enum Header {
        enum Authorization {
            static let field = "Authorization"
            static var value: String {
                guard let clientIDString = Bundle.main.object(forInfoDictionaryKey: "SPOTIFY_CLIENT_ID") as? String,
                      let clientSecretString = Bundle.main.object(forInfoDictionaryKey: "SPOTIFY_CLIENT_SECRET") as? String,
                      let clientID = clientIDString.toBase64,
                      let clientSecret = clientSecretString.toBase64
                else {
                    return ""
                }
                return "Basic \(clientID):\(clientSecret)"
            }
        }
        
        enum ContentType {
            static let field = "Content-Type"
            static let value = "application/x-www-form-urlencoded"
        }
    }
}
