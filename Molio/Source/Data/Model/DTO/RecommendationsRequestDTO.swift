struct RecommendationsRequestDTO: Encodable {
    
    // MARK: - 기본

    /// 가져올 추천 항목의 수. 기본값: 20. 최소: 1, 최대: 100.
    let limit: Int?

    /// 국가 코드. 예시: "ES"
    let market: String?

    /// 시드 아티스트 ID. 예시: "4NHQUGzhtTLFvgF5SZesLK"
    let seedArtists: String?

    /// 시드 장르. 예시: "classical,country"
    let seedGenres: String?

    // MARK: - 추가 속성

    /// 목표 어쿠스틱 정도 (비전자적 특성). 범위: 0.0 ~ 1.0
    let targetAcousticness: Double?

    /// 목표 댄서빌리티 (춤추기 적합성). 범위: 0.0 ~ 1.0
    let targetDanceability: Double?

    /// 목표 곡 길이 (밀리초 단위).
    let targetDurationMs: Int?

    /// 목표 에너지 수준. 범위: 0.0 ~ 1.0
    let targetEnergy: Double?

    /// 목표 기악 정도 (보컬 요소의 부재). 범위: 0.0 ~ 1.0
    let targetInstrumentalness: Double?

    /// 목표 키(음조). 범위: 0 ~ 11
    let targetKey: Int?

    /// 목표 라이브 정도 (라이브 환경 여부). 범위: 0.0 ~ 1.0
    let targetLiveness: Double?

    /// 목표 평균 음량 (데시벨 단위). 일반적으로 -60 ~ 0 사이
    let targetLoudness: Double?

    /// 목표 모드. 메이저 키: 1, 마이너 키: 0 (값이 높을수록 밝은 느낌)
    let targetMode: Int?

    /// 목표 인기 지수. 범위: 0 ~ 100
    let targetPopularity: Int?

    /// 목표 스피치니스 (가사 또는 음성의 비율). 범위: 0.0 ~ 1.0
    let targetSpeechiness: Double?

    /// 목표 템포 (BPM 단위).
    let targetTempo: Double?

    /// 목표 박자. 일반적으로 3, 4, 5 (각각 3/4, 4/4, 5/4 의미)
    let targetTimeSignature: Int?

    /// 목표 발렌스 (감정적 긍정성). 1에 가까울수록 밝고 행복한 느낌, 0에 가까울수록 우울하고 진지한 느낌.
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
    
    init(
        limit: Int = 20,
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
        targetValence: Double? = nil
    ) {
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
