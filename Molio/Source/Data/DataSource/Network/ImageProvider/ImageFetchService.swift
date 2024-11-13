import Foundation

protocol ImageFetchService {
    func fetchImage(from url: URL) async throws -> Data
}
