import Foundation

struct MockSpotifyAPIService: SpotifyAPIService {
    var spotifyAccessTokenProvider: SpotifyAccessTokenProvider
    
    init(spotifyAccessTokenProvider: SpotifyAccessTokenProvider = MockSpotifyAccessTokenProvider()) {
        self.spotifyAccessTokenProvider = spotifyAccessTokenProvider
    }
    
    func fetchRecommendedMusicISRCs(musicFilterEntity: MusicFilter) async -> [String] {
        let accessToken = await spotifyAccessTokenProvider.getAccessToken()
        
        var components = URLComponents(string: "https://api.spotify.com/v1/recommendations")!

        components.queryItems = [
            URLQueryItem(name: "seed_genres", value: musicFilterEntity.genres.joined(separator: ",")),
        ]
        
        guard let url = components.url else {
            print("URL 이상합니다.")
            return []
        }

        let request = buildFetchRecommendedMusicURLRequest(url: url, accessToken: accessToken)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    return []
                }
            }
            
            let recommendations = try JSONDecoder().decode(RecommendationsResponseDTO.self, from: data)
            
            let isrcs = recommendations.tracks.map { $0.externalIDs.isrc }
            
            return isrcs
        } catch {
            print("Error: \(error)")
            return []
        }
    }
    
    func buildFetchRecommendedMusicURLRequest(url: URL, accessToken: String) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }
}
