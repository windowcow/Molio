struct RecommendationsRequestDTO: Codable {
    
    // MARK: - 기본
    
    /// Default: 20. Minimum: 1. Maximum: 100.
    let limit: Int?
    
    /// Example: "ES"
    let market: String?
    
    /// Example: "4NHQUGzhtTLFvgF5SZesLK"
    let seedArtists: String?
    
    /// Example: "classical,country"
    let seedGenres: String?
    
    // MARK: - 추가 속성
    
    // 어쿠스틱성 (전자적이지 않음)
    let targetAcousticness: Double?
    
    // 춤추기 적합성
    let targetDanceability: Double?
    
    // 곡 길이
    let targetDurationMs: Int?
    
    // 에너지
    let targetEnergy: Double?
    
    // 보컬 요소가 얼마나 없는지
    let targetInstrumentalness: Double?
    
    // 음조(얼마나 높은지)
    let targetKey: Int?
    
    // 라이브 환경인지
    let targetLiveness: Double?
    
    // 평균 음량
    let targetLoudness: Double?
    
    // 메이저키: 1, 마이너 키: 0 (1일 수록 밝은 느낌임)
    let targetMode: Int?
    
    // 유명도
    let targetPopularity: Int?
    
    // 가사, 음성이 얼마나 많은지
    let targetSpeechiness: Double?
    
    // 빠르기 (BPM으로)
    let targetTempo: Double?
    
    // 박자 (일반적으로 3, 4, 5가 각각 3/4 4/4 5/4를 의미)
    let targetTimeSignature: Int?
    
    // 1일수록 밝고, 0일수록 우울한 노래
    let targetValence: Double?
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case limit
        case market
        case seedArtists = "seed_artists"
        case seedGenres = "seed_genres"
        
        case targetAcousticness = "target_acousticness"
        case targetDanceability = "target_danceability"
        case targetDurationMs = "target_duration_ms"
        case targetEnergy = "target_energy"
        case targetInstrumentalness = "target_instrumentalness"
        case targetKey = "target_key"
        case targetLiveness = "target_liveness"
        case targetLoudness = "target_loudness"
        case targetMode = "target_mode"
        case targetPopularity = "target_popularity"
        case targetSpeechiness = "target_speechiness"
        case targetTempo = "target_tempo"
        case targetTimeSignature = "target_time_signature"
        case targetValence = "target_valence"
    }
    
    init(limit: Int = 20,
         market: String? = nil,
         seedArtists: String? = nil,
         seedGenres: String? = nil,
         seedTracks: String? = nil,
         targetAcousticness: Double? = nil,
         targetDanceability: Double? = nil,
         targetDurationMs: Int? = nil,
         targetEnergy: Double? = nil,
         targetInstrumentalness: Double? = nil,
         targetKey: Int? = nil,
         targetLiveness: Double? = nil,
         targetLoudness: Double? = nil,
         targetMode: Int? = nil,
         targetPopularity: Int? = nil,
         targetSpeechiness: Double? = nil,
         targetTempo: Double? = nil,
         targetTimeSignature: Int? = nil,
         targetValence: Double? = nil) {
        
        self.limit = 20
        self.market = market
        self.seedArtists = seedArtists
        self.seedGenres = seedGenres
        
        self.targetAcousticness = targetAcousticness
        self.targetDanceability = targetDanceability
        self.targetDurationMs = targetDurationMs
        self.targetEnergy = targetEnergy
        self.targetInstrumentalness = targetInstrumentalness
        self.targetKey = targetKey
        self.targetLiveness = targetLiveness
        self.targetLoudness = targetLoudness
        self.targetMode = targetMode
        self.targetPopularity = targetPopularity
        self.targetSpeechiness = targetSpeechiness
        self.targetTempo = targetTempo
        self.targetTimeSignature = targetTimeSignature
        self.targetValence = targetValence
    }
}
