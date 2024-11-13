import Foundation

enum ImageFecthError: LocalizedError {
    case invalidURL
    case networkError
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL"
        case .networkError:
            return "이미지를 불러오는 중 네트워크 오류가 발생"
        case .noData:
            return "이미지 데이터 없음"
        }
    }
}
