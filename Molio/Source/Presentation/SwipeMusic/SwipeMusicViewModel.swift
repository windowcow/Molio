import Foundation
import Combine
import MusicKit
import AVFoundation

final class SwipeMusicViewModel: ObservableObject, AudioPlayable {
    var player: AVPlayer?
    
    @Published var music: Song?
    let musicService = MusicKitService()
    
    func fetchMusic() {
        Task {
                let music = await musicService.getMusic(with: "USAT22409172")
                self.music = music
                self.playMusic()
        }
    }
    
    func playMusic() {
        guard let url = music?.previewAssets?.first?.url else { return }
        player = AVPlayer(url: url)
        play()
    }

}
