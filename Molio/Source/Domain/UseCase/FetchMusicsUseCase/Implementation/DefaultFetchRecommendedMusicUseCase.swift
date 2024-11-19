struct DefaultFetchRecommendedMusicUseCase: FetchRecommendedMusicUseCase {
    private let musicRepository: RecommendedMusicRepository
    
    init(repository: RecommendedMusicRepository) {
        self.musicRepository = repository
    }
    
    func execute(genres: [String]) async throws -> [MolioMusic] {
        return try await musicRepository.fetchMusics(genres: genres)
    }
}
