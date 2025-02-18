import Foundation

struct DefaultFetchImageUseCase: FetchImageUseCase {
    private let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func execute(url: URL) async throws -> Data {
        return try await repository.fetchImage(from: url)
    }
}
