import Foundation

struct PlaylistEntity {
    let id: UUID
    let name: String
    let createdAt: Date
    let musicISRCs: [String]
    let filters: [String]
}
