import Foundation
import Combine
import MusicKit
import AVFoundation

final class SwipeMusicViewModel: ObservableObject {
    let musicPlayer = SwipeMusicPlayer()
    
    @Published var music: RandomMusic?
    let musicService = DefaultMusicKitService()
    
    func fetchMusic() {
        Task {
            let music = await musicService.getMusic(with: "USAT22409172")
            self.music = music
            self.loadAndPlaySongs(urls: [self.music!.previewAsset])
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
