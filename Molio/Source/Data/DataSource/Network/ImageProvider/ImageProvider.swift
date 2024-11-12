import Foundation

protocol ImageProvider {
    func fetchImage(from url: URL) async throws -> Data
}
