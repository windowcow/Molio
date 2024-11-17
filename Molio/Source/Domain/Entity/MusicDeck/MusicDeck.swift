import Combine

protocol MusicDeck {
    var currentMusicTrackModelPublisher: AnyPublisher<RandomMusic?, Never> { get }
    
    var nextMusicTrackModelPublisher: AnyPublisher<RandomMusic?, Never> { get }
    
    func likeCurrentMusic()
    
    func dislikeCurrentMusic()
}
