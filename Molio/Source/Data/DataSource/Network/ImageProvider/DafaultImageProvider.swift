import Foundation

final class DefaultImageProvider: ImageProvider {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await session.data(from: url)
            guard !data.isEmpty else {
                throw ImageError.noData
            }
            return data
        } catch URLError.badURL {
            throw ImageError.invalidURL
        } catch {
            throw ImageError.networkError
        }
    }
}
