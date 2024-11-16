import Foundation
import Combine

protocol PlaylistRepository {
    var playlistsPublisher: AnyPublisher<[PlaylistDTO], Never> { get }
    
    func addMusic(isrc: String, to playlistName: String)
    func deleteMusic(isrc: String, in playlistName: String)
    func moveMusic(isrc: String, in playlistName: String, fromIndex: Int, toIndex: Int)

    func fetchPlaylists() -> [PlaylistDTO]?
    func saveNewPlaylist(_ playlistName: String)
    func deletePlaylist(_ playlistName: String)
    func fetchPlaylist(for name: String) -> PlaylistDTO?
}
