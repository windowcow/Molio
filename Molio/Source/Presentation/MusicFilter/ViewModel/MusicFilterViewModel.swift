import SwiftUI

final class MusicFilterViewModel: ObservableObject {
    @Published private(set) var allGenres: [MusicGenre] // TODO: - 전체 장르 시드 불러오기
    @Published private(set) var selectedGenres: Set<MusicGenre>
    
    init(
        allGenres: [MusicGenre] = MusicGenre.allCases,
        selectedGenres: Set<MusicGenre> = []
    ) {
        self.allGenres = allGenres
        self.selectedGenres = selectedGenres
    }
    
    func toggleSelection(of genre: MusicGenre) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
    }
    
    func getAllGenres() {
        
    }
    
    func saveGenreSelection() {
        
    }
}
