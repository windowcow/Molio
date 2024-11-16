/// 음악 필터에 대한 엔티티입니다.
/// "pop"이나 "k-pop" 같은 장르들은 사용자가 [플레이리스트 설정] 필터에서 설정할 수 있습니다.
/// 설정된 필터를 기반으로 이 엔티티가 생성되며, 스포티파이 API의 노래 추천 요청에 사용됩니다.
struct MusicFilter {
    /// 사용자가 선택한 장르 목록입니다.
    /// 예시: ["pop", "k-pop"]
    var genres: [String]
}

extension MusicFilter {
    static let mock: MusicFilter = .init(
        genres: ["팝", "락", "재즈", "일렉트로닉", "힙합", "팝", "락", "재즈", "일렉트로닉", "힙합", "팝", "락", "재즈", "일렉트로닉", "힙합"]
    )
}
