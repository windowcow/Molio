import Combine

protocol MusicFilterProvider {
    func getMusicFilterPublisher() -> AnyPublisher<MusicFilter, Never>
}
