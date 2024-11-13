import AVFoundation

protocol AudioPlayer {
    func loadSongs(with urls:[URL])
    func play()
    func pause()
    func stop()
    func playNext()
}
