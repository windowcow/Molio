import Foundation

struct PlaylistDTO {
    let id: UUID
    let name: String
    let createdAt: Date
    let musics: [String]
    let filters: [String]
}
