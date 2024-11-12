import Combine

struct MockMusicFilterProvider: MusicFilterProvider {
    func getMusicFilterPublisher() -> AnyPublisher<MusicFilter, Never> {
        let musicFilter = MusicFilter(genres: ["k-pop"])
        
        return Just(musicFilter).eraseToAnyPublisher()
    }
}
