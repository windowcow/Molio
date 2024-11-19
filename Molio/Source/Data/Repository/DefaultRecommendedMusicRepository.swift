struct DefaultRecommendedMusicRepository: RecommendedMusicRepository {
    private let spotifyAPIService: SpotifyAPIService
    private let musicKitService: MusicKitService
    
    init(spotifyAPIService: SpotifyAPIService,
         musicKitService: MusicKitService
    ) {
        self.spotifyAPIService = spotifyAPIService
        self.musicKitService = musicKitService
    }
    
    func fetchMusics(with filter: MusicFilter) async throws -> [MolioMusic] {
        let isrcs = try await spotifyAPIService.fetchRecommendedMusicISRCs(with: filter)

        return try await withThrowingTaskGroup(of: MolioMusic?.self) { group in
            var musics: [MolioMusic] = []
            for isrc in isrcs {
                group.addTask {
                    return await musicKitService.getMusic(with: isrc)
                }
            }
            
            for try await music in group {
                if let music {
                    musics.append(music)
                }
            }
            
            return musics
        }
    }
    
    func fetchMusicGenres() async throws -> [MusicGenre] {
        let availableGenreSeedsDTO = try await spotifyAPIService.fetchAvailableGenreSeeds()
        let musicGenreArr = availableGenreSeedsDTO.genres.compactMap { MusicGenre(rawValue: $0) }
        return musicGenreArr
    }
}
