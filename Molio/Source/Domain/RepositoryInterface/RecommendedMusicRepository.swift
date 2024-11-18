protocol RecommendedMusicRepository {
    func fetchMusics(with filter: MusicFilter) async throws -> [RandomMusic]
}
