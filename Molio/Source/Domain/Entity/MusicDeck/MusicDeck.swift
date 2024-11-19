import Combine

protocol MusicDeck {
    var currentMusicTrackModelPublisher: AnyPublisher<MolioMusic?, Never> { get }
    
    var nextMusicTrackModelPublisher: AnyPublisher<MolioMusic?, Never> { get }
    
    func likeCurrentMusic()
    
    func dislikeCurrentMusic()
}
