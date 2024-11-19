struct MockFetchAvailableGenresUseCase: FetchAvailableGenresUseCase {
    var musicGenreArrToReturn: [MusicGenre]
    
    init(
        musicGenreArrToReturn: [MusicGenre] = Array(MusicGenre.allCases.prefix(20))
    ) {
        self.musicGenreArrToReturn = musicGenreArrToReturn
    }
    
    func execute() async throws -> [MusicGenre] {
        return musicGenreArrToReturn
    }
}
