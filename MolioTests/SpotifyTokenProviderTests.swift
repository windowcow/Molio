import XCTest
@testable import Molio

final class SpotifyTokenProviderTests: XCTestCase {
    private var sut: DefaultSpotifyTokenProvider!

    override func setUpWithError() throws {
        let mockNetworkProvider = MockNetworkProvider()
        sut = DefaultSpotifyTokenProvider(networkProvider: mockNetworkProvider)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_accessToken이_nil이_아니고_만료시간까지_300초_넘게_남은_경우_getAccessToken메서드를_호출하면_네트워크_요청_없이_accessToken바로_반환한다() async throws {
        // Given
        let firstToken = "abcd"
        let newTokenResponseDTO = SpotifyAccessTokenResponseDTO(accessToken: firstToken, tokenType: "", expiresIn: 500)
        let mockNetworkProvider = MockNetworkProvider()
        mockNetworkProvider.dtoToReturn = newTokenResponseDTO
        sut = DefaultSpotifyTokenProvider(networkProvider: mockNetworkProvider)
        _ = try await sut.getAccessToken() // 토큰 1번 주입
        
        // When
        let result = try await sut.getAccessToken()
        
        // Then
        XCTAssertEqual(result, firstToken)
        XCTAssertEqual(mockNetworkProvider.requestCallCount, 1)
    }
    
    func test_accessToken이_nil일_경우_getAccessToken메서드를_호출하면_accessToken을_새로_발급받아서_반환한다() async throws {
        // Given
        let newToken = "abcd"
        let newTokenResponseDTO = SpotifyAccessTokenResponseDTO(accessToken: newToken, tokenType: "", expiresIn: 0)
        let mockNetworkProvider = MockNetworkProvider()
        mockNetworkProvider.dtoToReturn = newTokenResponseDTO
        sut = DefaultSpotifyTokenProvider(networkProvider: mockNetworkProvider)
        
        // When
        let result = try await sut.getAccessToken()
        
        // Then
        XCTAssertEqual(result, newToken)
        XCTAssertTrue(mockNetworkProvider.isRequestCalled)
    }
    
    func test_isTokenExpiringSoon이_true일_경우_getAccessToken메서드를_호출하면_accessToken을_새로_발급받아서_반환한다() async throws {
        // Given
        let newToken = "abcd"
        let newTokenResponseDTO = SpotifyAccessTokenResponseDTO(accessToken: newToken, tokenType: "", expiresIn: 0)
        let mockNetworkProvider = MockNetworkProvider()
        mockNetworkProvider.dtoToReturn = newTokenResponseDTO
        sut = DefaultSpotifyTokenProvider(networkProvider: mockNetworkProvider)
        _ = try await sut.getAccessToken()
        
        // When
        let result = try await sut.getAccessToken()
        
        // Then
        XCTAssertEqual(result, newToken)
        XCTAssertEqual(mockNetworkProvider.requestCallCount, 2)
    }
    
    func test_새로운_access_Token_요청이_실패했을_경우_TokenProviderError의_failedToCreateToken를_throw한다() async {
        // Given
        let mockNetworkProvider = MockNetworkProvider()
        mockNetworkProvider.isErrorThrow = true
        mockNetworkProvider.errorToThrow = NetworkError.requestFail(code: .internalServerError)
        sut = DefaultSpotifyTokenProvider(networkProvider: mockNetworkProvider)
        
        // When
        do {
            let _ = try await sut.getAccessToken()
        } catch {
            // Then
            XCTAssertEqual(error as! SpotifyTokenProviderError, SpotifyTokenProviderError.failedToCreateToken)
        }
    }
}
