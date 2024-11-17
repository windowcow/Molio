struct MockSpotifyAPIService: SpotifyAPIService {
    var isrcsToReturn: [String] = [
        "USRC11300369", "USAT21702430", "GBUM71101813", "QZ45A1600041", "USSUB0771012",
        "QMSAL1200001", "KRA401800096", "USAT21502909", "USUG11700631", "USA371627635",
        "USVI20400540", "USSUB0877710", "USA371382531", "USEP41227004", "USVR91379302",
        "DEE861400019", "GBUM71204769", "USIR10211291", "USUM71703085", "USSUB1408301"
    ]
    var genreSeedsToReturn: SpotifyAvailableGenreSeedsDTO = SpotifyAvailableGenreSeedsDTO(
        genres: [
            "acoustic", "afrobeat", "alt-rock", "alternative",
            "ambient", "anime", "black-metal", "bluegrass",
            "blues", "bossanova", "brazil", "breakbeat",
            "british", "cantopop", "chicago-house", "children",
            "chill", "classical", "club", "comedy", "country",
            "dance", "dancehall", "death-metal"
        ]
    )
    
    func fetchRecommendedMusicISRCs(musicFilter: MusicFilter) async throws -> [String] {
        return isrcsToReturn
    }
    
    func fetchAvailableGenreSeeds() async throws -> SpotifyAvailableGenreSeedsDTO {
        return genreSeedsToReturn
    }
}
