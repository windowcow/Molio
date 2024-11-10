import Foundation

enum SpotifyAPI {
    case getRecommendations(genres: [String])
    
    var description: String {
        switch self {
        case .getRecommendations(let genres): "[\(genres.joined(separator: ","))] 장르에 대한 추천 음악 불러오기 엔드포인트"
        }
    }
}

extension SpotifyAPI: EndPoint {
    var base: String {
        "https://api.spotify.com/v1"
    }
    
    var path: String {
        switch self {
        case .getRecommendations: "/recommendations"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecommendations: .get
        }
    }
    
    var headers: [String: String]? {
        return [
            Header.Authorization.field: Header.Authorization.value
        ]
    }
    
    var body: Data? {
        switch self {
        case .getRecommendations: nil
        }
    }
    
    var params: [String: String] {
        switch self {
        case .getRecommendations(let genres):
            return [
                "limit": "20", // TODO: - 개수 정하기
                "market": "KR",
                "seed_genres": genres.joined(separator: ",")
            ]
        }
    }
    
    var url: URL? {
        switch self {
        case .getRecommendations:
            guard var components = URLComponents(string: base + path) else { return nil }
            components.queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
            return components.url
        }
    }
}

extension SpotifyAPI {
    enum Header {
        enum Authorization {
            static let field = "Authorization"
            static var value: String {
                let accessToken = "" // TODO: - 토큰 받아와서 연결하기
                return "Bearer \(accessToken)"
            }
        }
    }
}
