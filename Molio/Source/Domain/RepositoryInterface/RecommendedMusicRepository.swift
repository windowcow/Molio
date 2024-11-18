protocol RecommendedMusicRepository {
    func fetchMusics(with filter: MusicFilter) async throws -> [RandomMusic]
    func fetchMusicGenres() async throws -> [MusicGenre]
}
