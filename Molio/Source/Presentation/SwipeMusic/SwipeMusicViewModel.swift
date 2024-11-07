import Foundation
import Combine
import MusicKit

class SwipeMusicViewModel: ObservableObject {
    @Published var music: Song?
    let musicService = MusicKitService()
    
    func fetchMusic() {
        if musicService.checkAuthorizationStatus() {
            Task {
                let music = await musicService.getMusic(with: "USAT22409172")
                self.music = music
            }
        } else {
            music = nil
        }
    }
}
