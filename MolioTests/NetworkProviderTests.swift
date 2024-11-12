import XCTest
@testable import Molio

final class NetworkProviderTests: XCTestCase {
    private var sut: NetworkProvider!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        sut = DefaultNetworkProvider(session: urlSession)
    }

    override func tearDownWithError() throws {
        sut = nil
        MockURLProtocol.requestHandler = nil
    }
    
    // MARK: - GET
    
    func test_SpotifyAPI의_getRecommendations_엔드포인트로_요청시_request를_제대로_생성한다() async throws {
        // Given
        var isRequestContainsCorrectPath: Bool!
        var requestHttpMethod: String!
        var requestAuthorizationHeaderValue: String!
        MockURLProtocol.requestHandler = { request in
            let containCorrectPath2 = request.url?.pathComponents.contains("v1")
            let containCorrectPath1 = request.url?.pathComponents.contains("recommendations")
            isRequestContainsCorrectPath = containCorrectPath1! && containCorrectPath2!
            requestHttpMethod = request.httpMethod
            requestAuthorizationHeaderValue = request.value(forHTTPHeaderField: "Authorization")
            return (HTTPURLResponse(), RecommendationsResponseDTO.dummyData)
        }
        let apiRequest = SpotifyAPI.getRecommendations(genres: ["Pop"], accessToken: "abc")

        // When
        let _: RecommendationsResponseDTO = try await sut.request(apiRequest)

        // Then
        XCTAssertTrue(isRequestContainsCorrectPath)
        XCTAssertEqual(requestHttpMethod, apiRequest.httpMethod.value)
        XCTAssertTrue(requestAuthorizationHeaderValue.contains("abc"))
    }
    
    // MARK: - POST
    
    func test_SpotifyAuthorizationAPI의_createAccessToken_엔드포인트로_요청시_request를_제대로_생성한다() async throws {
        // Given
        var isRequestContainsCorrectPath: Bool!
        var requestHttpMethod: String!
        MockURLProtocol.requestHandler = { request in
            let containCorrectPath1 = request.url?.pathComponents.contains("api")
            let containCorrectPath2 = request.url?.pathComponents.contains("token")
            isRequestContainsCorrectPath = containCorrectPath1! && containCorrectPath2!
            requestHttpMethod = request.httpMethod
            return (HTTPURLResponse(), SpotifyAccessTokenResponseDTO.dummyData)
        }
        let apiRequest = SpotifyAuthorizationAPI.createAccessToken
        
        // When
        let _: SpotifyAccessTokenResponseDTO = try await sut.request(apiRequest)

        // Then
        XCTAssertTrue(isRequestContainsCorrectPath)
        XCTAssertEqual(requestHttpMethod, apiRequest.httpMethod.value)
    }
}

