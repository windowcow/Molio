import Foundation
import AVFoundation

protocol AudioPlayable {
    var player: AVPlayer? { get set }
    func play()
    func pause()
}

extension AudioPlayable {
    func play() {
        guard let player = player else { return }
        
        player.play()
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { time in
            print("Current playback time: \(time.seconds)") // TODO: progress 바 추가
        }
    }
    
    func pause() {
        guard let player = player else { return }
        player.pause()
    }
    
    func stop() {
        guard let player = player else { return }
        player.pause()
        player.seek(to: .zero)
    }
}
