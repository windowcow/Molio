protocol FetchMusicsUseCase {
    func execute(genres: [String]) async throws -> [Music]
}
