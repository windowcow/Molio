struct DefaultRecommendedMusicRepository: RecommendedMusicRepository {
    private let spotifyAPIService: SpotifyAPIService
    private let musicKitService: MusicKitService
    
    init(spotifyAPIService: SpotifyAPIService,
         musicKitService: MusicKitService
    ) {
        self.spotifyAPIService = spotifyAPIService
        self.musicKitService = musicKitService
    }
    
    /// 넘겨받은 필터에 기반하여 추천된 랜덤 음악 목록을 가져옵니다.
    ///  - Parameters: 추천받을 랜덤 음악에 대한 필터 (플레이리스트 필터)
    ///  - Returns: `RandomMusic`의 배열
    func fetchMusics(with filter: MusicFilter) async throws -> [RandomMusic] {
        let isrcs = try await spotifyAPIService.fetchRecommendedMusicISRCs(with: filter)

        return try await withThrowingTaskGroup(of: RandomMusic?.self) { group in
            var musics: [RandomMusic] = []
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
