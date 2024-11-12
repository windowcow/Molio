import Foundation

protocol FetchImageUseCase {
    func execute(url: URL) async throws -> Data
}
