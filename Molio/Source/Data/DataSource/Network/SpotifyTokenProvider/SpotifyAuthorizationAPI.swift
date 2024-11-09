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
    var baseURL: URL { URL(string: "https://accounts.spotify.com/api")! }
    
    var path: String {
        switch self {
        case .createAccessToken:
            let params: [String: String] = ["grant_type": "client_credentials"]
            return makeFullPath(with: "", params: params)
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
}

extension SpotifyAuthorizationAPI {
    private func makeFullPath(with path: String, params: [String: String]) -> String {
        return params.reduce(path + "?") { result, param in
            result + "&\(param.key)=\(param.value)"
        }
    }
    
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
