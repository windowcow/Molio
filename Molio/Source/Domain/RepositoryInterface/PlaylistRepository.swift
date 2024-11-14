import Foundation

protocol PlaylistRepository {
    func addMusic(isrc: String, to playlistName: String)
    func deleteMusic(isrc: String, in playlistName: String)
    func moveMusic(isrc: String, in playlistName: String, fromIndex: Int, toIndex: Int)
    
    func fetchMusics(in playlistName: String) -> [String]?
    func saveNewPlaylist(_ playlistName: String)
    func deletePlaylist(_ playlistName: String)
    
    func getPlaylistID(for playlistName: String) -> UUID?
}
