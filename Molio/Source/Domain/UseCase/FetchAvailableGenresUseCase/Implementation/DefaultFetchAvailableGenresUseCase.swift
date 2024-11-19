struct DefaultFetchAvailableGenresUseCase: FetchAvailableGenresUseCase {
    private let recommendedMusicRepository: RecommendedMusicRepository
    
    init(recommendedMusicRepository: RecommendedMusicRepository) {
        self.recommendedMusicRepository = recommendedMusicRepository
    }
    
    func execute() async throws -> [MusicGenre] {
        return try await recommendedMusicRepository.fetchMusicGenres()
    }
}
