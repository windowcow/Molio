import Foundation

protocol PlaylistRepository {
    func saveMusic(isrc: String, to playlist: UUID)
    func deleteMusic(isrc: String)
    func moveMusic(isrc: String, in playlist: UUID, fromIndex: Int, toIndex: Int)
    
    func fetchPlaylist(from playlist: UUID) -> [String]
    func saveNewPlaylist(name: String)
    func deletePlaylist(name: String)
}
