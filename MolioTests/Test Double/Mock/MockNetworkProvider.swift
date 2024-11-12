@testable import Molio

final class MockNetworkProvider: NetworkProvider {
    var isErrorThrow: Bool = false
    var dtoToReturn: Decodable?
    var errorToThrow: Error?
    var isRequestCalled: Bool = false
    
    func request<T: Decodable>(_ endPoint: any Molio.EndPoint) async throws -> T {
        isRequestCalled = true
        if isErrorThrow {
            throw errorToThrow!
        } else {
            return dtoToReturn as! T
        }
    }
}
