struct DefaultRecommendedMusicRepository: RecommendedMusicRepository {
    private let spotifyAPIService: SpotifyAPIService
    private let musicKitService: MusicKitService
    
    init(spotifyAPIService: SpotifyAPIService,
         musicKitService: MusicKitService
    ) {
        self.spotifyAPIService = spotifyAPIService
        self.musicKitService = musicKitService
    }
    
    func fetchMusics(genres: [String]) async throws -> [MolioMusic] {
        let musicFilter = MusicFilter(genres: genres)
        let isrcs = try await spotifyAPIService.fetchRecommendedMusicISRCs(musicFilter: musicFilter)

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
}
