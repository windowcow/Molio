import Foundation

enum SpotifyAPI {
    case getRecommendations(genres: [String], accessToken: String)
    
    var description: String {
        switch self {
        case .getRecommendations(let genres, _): "[\(genres.joined(separator: ","))] 장르에 대한 추천 음악 불러오기 엔드포인트"
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
        switch self {
        case .getRecommendations(let genres, let accessToken):
            return makeAuthorizationHeader(with: accessToken)
        }
    }
    
    var body: Data? {
        switch self {
        case .getRecommendations: nil
        }
    }
    
    var params: [String: String] {
        switch self {
        case .getRecommendations(let genres, _):
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
    private func makeAuthorizationHeader(with accessToken: String) -> [String: String] {
        return ["Authorization": "Bearer \(accessToken)"]
    }
}
