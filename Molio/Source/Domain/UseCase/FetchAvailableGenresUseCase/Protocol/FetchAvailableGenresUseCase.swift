protocol FetchAvailableGenresUseCase {
    func execute() async throws -> [MusicGenre]
}
