struct DefaultFetchMusicsUseCase: FetchMusicsUseCase {
    private let musicRepository: MusicRepository
    
    init(repository: MusicRepository) {
        self.musicRepository = repository
    }
    
    func execute(genres: [String]) async throws -> [Music] {
        return try await musicRepository.fetchMusics(genres: genres)
    }
}
