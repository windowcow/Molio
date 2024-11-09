import Foundation

// MARK: - Protocol

protocol NetworkProvider {
    /// 요청을 수행하고 응답 데이터를 반환하는 메서드
    ///  - Parameters: 요청 메시지
    ///  - Throws
    ///    - 요청이 정상적이지 않은 경우 발생
    ///    - 응답이 정상적이지 않은 경우 발생
    ///  - Returns: 응답 Data
    @discardableResult
    func request<T: Decodable>(_ endPoint: EndPoint) async throws -> T
}

private extension NetworkProvider {
    func makeURLRequest(of endPoint: EndPoint) -> URLRequest {
        let url = endPoint.baseURL.appendingPathComponent(endPoint.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        endPoint.headers?.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpBody = endPoint.body
        
        return urlRequest
    }
}

// MARK: - Implementation

final class DefaultNetworkProvider: NetworkProvider {
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    @discardableResult
    func request<T: Decodable>(_ endPoint: any EndPoint) async throws -> T {
        let urlRequest = makeURLRequest(of: endPoint)
        let (data, response) = try await session.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseNotHTTP
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            let statusCode = HTTPResponseStatusCode(rawValue: httpResponse.statusCode)
            throw NetworkError.requestFail(code: statusCode)
        }
        let dto = try decoder.decode(T.self, from: data)
        return dto
    }
}
