import Foundation

struct PlaylistEntity {
    let id: UUID
    let name: String
    let createdAt: Date
    let musics: [String]
    let filters: [String]
}
