import Combine

struct MockMusicFilterProvider: MusicFilterProvider {
    func getMusicFilterPublisher() -> AnyPublisher<MusicFilter, Never> {
        let musicFilter = MusicFilter(genres: [.kPop])
        
        return Just(musicFilter).eraseToAnyPublisher()
    }
}
