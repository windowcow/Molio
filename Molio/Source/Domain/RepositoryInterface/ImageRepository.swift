import Foundation

protocol ImageRepository {
    func fetchImage(from url: URL) async throws -> Data
}
