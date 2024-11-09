import Foundation

protocol EndPoint {
    /// API 베이스 URL
    var baseURL: URL { get }
    
    /// 엔드포인트 `URL`을 만들기 위해 `baseURL`에 추가할 경로
    var path: String { get }
    
    /// 요청에 사용할 HTTP Method
    var httpMethod: HTTPMethod { get }
    
    /// 요청에 사용할 헤더
    var headers: [String: String]? { get }
    
    /// 요청에 사용할 바디 데이터
    var body: Data? { get }
}
