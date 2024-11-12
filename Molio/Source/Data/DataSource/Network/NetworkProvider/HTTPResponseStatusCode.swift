/// Spotify API 응답 코드 기반
/// - https://developer.spotify.com/documentation/web-api/concepts/api-calls
enum HTTPResponseStatusCode: Int {
    // 2xx: 성공
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204

    // 3xx: 리다이렉션
    case notModified = 304

    // 4xx: 클라이언트 오류
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case notFound = 404
    case tooManyReqiests = 429

    // 5xx: 서버 오류
    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503

    var description: String {
        let code = self.rawValue
        switch self {
        case .ok: return "(\(code)) 요청 성공"
        case .created: return "(\(code)) 요청 성공 + 새 리소스 생성"
        case .accepted: return "(\(code)) 요청이 수락되었으나 아직 처리되지 않음"
        case .noContent: return "(\(code)) 요청은 성공했으나 message body가 존재하지 않음"
        case .notModified: return "(\(code)) 리소스 변경 없음 (캐시된 응답을 사용하세요)"
        case .badRequest: return "(\(code)) 잘못된 요청"
        case .unAuthorized: return "(\(code)) 인증 필요"
        case .forbidden: return "(\(code)) 요청이 거절됨 (권한 없음)"
        case .notFound: return "(\(code)) 리소스를 찾을 수 없음"
        case .tooManyReqiests: return "(\(code)) 요청이 너무 많음"
        case .internalServerError: return "(\(code)) 서버 내부 오류"
        case .badGateway: return "(\(code)) 잘못된 게이트웨이"
        case .serviceUnavailable: return "(\(code)) 서비스 이용 불가"
        }
    }
}
