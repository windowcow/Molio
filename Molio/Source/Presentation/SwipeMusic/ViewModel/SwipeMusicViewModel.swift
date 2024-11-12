import Foundation
import Combine
import MusicKit

final class SwipeMusicViewModel: ObservableObject {
    @Published var musics: [RandomMusic] = []
    
    let fetchMusicsUseCase: FetchMusicsUseCase
    
    init() {
        let mockSpotifyAPIService = MockSpotifyAPIService()
        let defaultMusicKitService = DefaultMusicKitService()
        let defaultMusicRepository = DefaultMusicRepository(
            spotifyAPIService: mockSpotifyAPIService,
            musicKitService: defaultMusicKitService
        )
        self.fetchMusicsUseCase = DefaultFetchMusicsUseCase(repository: defaultMusicRepository)
    }
    
    func fetchMusic() {
        Task {
            do {
                musics = try await fetchMusicsUseCase.execute(genres: ["k-pop"])
            } catch {
                print("error")
            }
        }
    }
}
