import Foundation

struct DefaultImageRepository: ImageRepository {
    private let imageProvider: ImageProvider
    
    init(imageProvider: ImageProvider) {
        self.imageProvider = imageProvider
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        return try await imageProvider.fetchImage(from: url)
    }
}
