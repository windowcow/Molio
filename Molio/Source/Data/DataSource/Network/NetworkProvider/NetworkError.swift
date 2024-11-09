import Foundation

enum NetworkError: LocalizedError {
    case invalidURLString
    case requestFail(code: HTTPResponseStatusCode?)
    case responseNotHTTP
    case urlDownloadsError

    var errorDescription: String? {
        switch self {
        case .invalidURLString:
            return "잘못된 URL"
        case let .requestFail(code):
            let base = "요청 실패 "
            if let code = code {
                return base + "\(code.rawValue)"
            } else {
                return base
            }
        case .responseNotHTTP:
            return "응답이 HTTP가 아님"
        case .urlDownloadsError:
            return "URL 콘텐츠 다운로드 에러"
        }
    }
}
