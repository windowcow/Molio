//
//  NetworkProviderTests.swift
//  MolioTests
//
//  Created by 김영빈 on 11/10/24.
//

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
    
    // MARK: - POST
    
    func test_SpotifyAuthorizationAPI의_createAccessToken_엔드포인트로_요청시_request를_제대로_생성한다() async throws {
        // Given
        var isRequestContainsCorrectPath: Bool!
        var requestHttpMethod: String!
        MockURLProtocol.requestHandler = { request in
            isRequestContainsCorrectPath = request.url?.pathComponents.contains("token")
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

