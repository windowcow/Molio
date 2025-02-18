import Foundation

final class CreatePlaylistViewModel: ObservableObject {
    private let createPlaylistUseCase: CreatePlaylistUseCase
    private let changeCurrentPlaylistUseCase: ChangeCurrentPlaylistUseCase
    private var playlistId: UUID?
    init(
        createPlaylistUseCase: CreatePlaylistUseCase,
        changeCurrentPlaylistUseCase: ChangeCurrentPlaylistUseCase
    ) {
        self.createPlaylistUseCase = createPlaylistUseCase
        self.changeCurrentPlaylistUseCase = changeCurrentPlaylistUseCase
    }
    
    func createPlaylist(named name: String) async {
        playlistId = await createPlaylistUseCase.execute(playlistName: name)
    }
    
    func changeCurrentPlaylist() {
        guard let playlistId else { return }
        changeCurrentPlaylistUseCase.execute(playlistId: playlistId)
    }
}

