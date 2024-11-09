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
        "https://accounts.spotify.com/api"
    }
    
    var path: String {
        switch self {
        case .createAccessToken:
            return "/token"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .createAccessToken: return .post
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
        case .createAccessToken: return nil
        }
    }
    
    var params: [String: String] {
        switch self {
        case .createAccessToken:
            return ["grant_type": "client_credentials"]
        }
    }
    
    var url: URL? {
        switch self {
        case .createAccessToken:
            guard var components = URLComponents(string: base + path) else { return nil }
            components.queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
            return components.url
        }
    }
}

extension SpotifyAuthorizationAPI {
    enum Header {
        enum Authorization {
            static let field = "Authorization"
            static var value: String {
                // TODO: - Base64 인코딩
                guard let clientID = Bundle.main.object(forInfoDictionaryKey: "SPOTIFY_CLIENT_ID"),
                      let clientSecret = Bundle.main.object(forInfoDictionaryKey: "SPOTIFY_CLIENT_SECRET") else {
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
