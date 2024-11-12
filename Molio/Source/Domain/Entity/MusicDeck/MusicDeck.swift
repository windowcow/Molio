import Foundation
import Combine

protocol MusicDeck {
    func musicPublisher(at: Int) -> AnyPublisher<RandomMusic?, Never>
    
    func likeCurrentMusic()
    
    func dislikeCurrentMusic()
}
