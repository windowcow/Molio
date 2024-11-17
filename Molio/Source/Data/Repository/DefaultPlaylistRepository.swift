import Foundation
import CoreData
import Combine

final class DefaultPlaylistRepository: PlaylistRepository {
    private let context: NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    private let playlistsSubject = PassthroughSubject <[PlaylistEntity], Never>()
    
    private let alertNotFoundPlaylist: String = "해당 플레이리스트를 못 찾았습니다."
    private let alertNotFoundMusicsinPlaylist: String = "플레이리스트에 음악이 없습니다."
    private let alertFailDeletePlaylist: String = "플레이리스트를 삭제할 수 없습니다"
    
    var playlistsPublisher: AnyPublisher<[PlaylistEntity], Never> {
        playlistsSubject.eraseToAnyPublisher()
    }
    
    init() {
        context = PersistenceManager.shared.context
    }
    
    init (context: NSManagedObjectContext) {
        self.context = context
        setupChangeObserver()
    }
    
    func addMusic(isrc: String, to playlistName: String) {
        guard let playlist = fetchRawPlaylist(for: playlistName) else { return }
        
        playlist.musicISRCs.append(isrc)
        saveContext()
    }
    
    func deleteMusic(isrc: String, in playlistName: String) {
        guard let playlist = fetchRawPlaylist(for: playlistName) else { return }
        
        playlist.musicISRCs.removeAll { $0 == isrc }
        saveContext()
    }
    
    func moveMusic(isrc: String, in playlistName: String, fromIndex: Int, toIndex: Int) {
        guard let playlist = fetchRawPlaylist(for: playlistName),
              playlist.musicISRCs.indices.contains(fromIndex),
              playlist.musicISRCs.indices.contains(toIndex) else { return }
        
        if playlist.musicISRCs[fromIndex] == isrc {
            let musicToMove = playlist.musicISRCs.remove(at: fromIndex)
            playlist.musicISRCs.insert(musicToMove, at: toIndex)
            
            saveContext()
        }
    }
    
    func fetchPlaylists() -> [PlaylistEntity]? {
        let fetchRequest: NSFetchRequest<MolioPlaylist> = MolioPlaylist.fetchRequest()
        do {
            let playlists = try context.fetch(fetchRequest)
            let playlistEntitys = playlists.map { playlist in
                PlaylistEntity(
                    id: playlist.id,
                    name: playlist.name,
                    createdAt: playlist.createdAt,
                    musicISRCs: playlist.musicISRCs,
                    filters: playlist.filters
                )
            }
            return playlistEntitys
        } catch {
            print("Failed to fetch playlists: \(error)")
            return nil
        }
    }
    
    func saveNewPlaylist(_ playlistName: String) {
        let playlist = MolioPlaylist(context: context)
        
        playlist.id = UUID()
        playlist.name = playlistName
        playlist.filters = []
        playlist.createdAt = Date()
        playlist.musicISRCs = []
        
        saveContext()
    }
    
    func deletePlaylist(_ playlistName: String) {
        guard let playlist = fetchRawPlaylist(for: playlistName) else { return }
        
        context.delete(playlist)
        saveContext()
    }
    
    func fetchPlaylist(for name: String) -> PlaylistEntity? {
        let fetchRequest: NSFetchRequest<MolioPlaylist> = MolioPlaylist.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            guard let playlist = try context.fetch(fetchRequest).first else { return nil }
            return PlaylistEntity(
                id: playlist.id,
                name: playlist.name,
                createdAt: playlist.createdAt,
                musicISRCs: playlist.musicISRCs,
                filters: playlist.filters)
            
        } catch {
            print("Failed to fetch playlist: \(error)")
            return nil
        }
    }
    
    
    
    // MARK: - Private Method
    
    private func setupChangeObserver() {
        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange, object: context)
            .sink { [weak self]_ in
                self?.fetchPlaylistsAndUpdate()
            }
            .store(in: &cancellables)
    }
    
    private func fetchPlaylistsAndUpdate() {
        guard let playlists = fetchPlaylists() else { return }
        playlistsSubject.send(playlists)
    }
    
    /// 현재 데이터 저장하기
    private func saveContext() {
        PersistenceManager.shared.saveContext()
    }
    
    private func fetchPlaylist(id: UUID) -> MolioPlaylist? {
        let fetchRequest: NSFetchRequest<MolioPlaylist> = MolioPlaylist.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let playlists = try context.fetch(fetchRequest)
            return playlists.first
        } catch {
            showAlert(alertNotFoundPlaylist)
            return nil
        }
    }
    
    private func fetchRawPlaylist(for name: String) -> MolioPlaylist? {
        let fetchRequest: NSFetchRequest<MolioPlaylist> = MolioPlaylist.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let playlists = try context.fetch(fetchRequest)
            return playlists.first
        } catch {
            print("Failed to fetch playlist: \(error)")
            return nil
        }
    }
    
    // TODO: 알림창 추가
    private func showAlert(_ context: String) {
        print(context)
    }
}
