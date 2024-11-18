struct DefaultFetchRecommendedMusicUseCase: FetchRecommendedMusicUseCase {
    private let musicRepository: RecommendedMusicRepository
    
    init(repository: RecommendedMusicRepository) {
        self.musicRepository = repository
    }
    
    func execute(with filter: MusicFilter) async throws -> [RandomMusic] {
        return try await musicRepository.fetchMusics(with: filter)
    }
}
