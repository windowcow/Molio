protocol MusicRepository {
    /// 장르를 통해 Music 정보를 가져옵니다.
    ///  - Parameters: filter할 genres 문자열 배열
    ///  - Returns: 응답 Data
    func fetchMusics(genres: [String]) async throws -> [RandomMusic]
}
