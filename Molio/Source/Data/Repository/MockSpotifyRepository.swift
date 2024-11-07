import Foundation

struct MockSpotifyRepository: SpotifyRepository {
    var spotifyAPIService: SpotifyAPIService
    
    init(spotifyAPIService: SpotifyAPIService = MockSpotifyAPIService()) {
        self.spotifyAPIService = spotifyAPIService
    }
    
    func fetchRecommendedSong(musicFilter: MusicFilterEntity) async -> [String] {
        return await spotifyAPIService.fetchRecommendedMusicISRCs(musicFilterEntity: musicFilter)
    }
}
