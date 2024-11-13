import AVFoundation

final class SwipeMusicPlayer: AudioPlayer {
    var player: AVQueuePlayer?
    var looper: AVPlayerLooper?
    var updatePlaybackTime: ((Double) -> Void)?
    private var timeObserverToken: Any?
    
    func loadSongs(with urls: [URL]) {
        let items = urls.map { AVPlayerItem(url: $0) }
        player = AVQueuePlayer(items: items)
        
        guard let player = player else { return }
        if let firstItem = items.first {
            looper = AVPlayerLooper(player: player, templateItem: firstItem)
        }
        
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
            timeObserverToken = nil
        }
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1),
                                                           queue: .main) { [weak self] time in
            self?.updatePlaybackTime?(time.seconds)
        }
    }
    
    func play() {
        guard let player = player else { return }
        player.play()
    }
    
    func pause() {
        guard let player = player else { return }
        player.pause()
    }
    
    func stop() {
        guard let player = player else { return }
        player.pause()
        player.seek(to: .zero)
        looper = nil
    }
    
    func playNext() {
        guard let player = player else { return }
        player.advanceToNextItem()
        
        if let currentItem = player.currentItem {
            looper = AVPlayerLooper(player: player, templateItem: currentItem)
        }
    }
}
