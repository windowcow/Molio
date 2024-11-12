import AVFoundation

protocol AudioPlayable {
    var player: AVQueuePlayer? { get set }
    var looper: AVPlayerLooper? { get set }
    var updatePlaybackTime: ((Double) -> Void)? { get set }
    
    func loadSongs(with urls:[URL])
    func play()
    func pause()
    func stop()
    func playNext()
}
