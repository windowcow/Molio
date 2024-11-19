protocol FetchRecommendedMusicUseCase {
    func execute(genres: [String]) async throws -> [MolioMusic]
}
