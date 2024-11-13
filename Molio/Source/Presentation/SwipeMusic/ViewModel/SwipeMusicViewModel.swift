import Foundation
import Combine
import MusicKit

final class SwipeMusicViewModel: ObservableObject {
    @Published var musics: [RandomMusic] = []
    private let musicPlayer = SwipeMusicPlayer()

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
                self.loadAndPlaySongs(urls: musics.map{ $0.previewAsset})
                
            } catch {
                print("error")
            }
        }
    }
    
    func loadAndPlaySongs(urls: [URL]) {
        musicPlayer.loadSongs(with: urls)
        musicPlayer.play()
    }
    
    func nextSong() {
        musicPlayer.playNext()
    }
}
