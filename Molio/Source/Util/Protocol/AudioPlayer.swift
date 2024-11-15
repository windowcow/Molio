import AVFoundation

protocol AudioPlayer {
    func loadSong(with url: URL)
    func play()
    func pause()
    func stop()
}
