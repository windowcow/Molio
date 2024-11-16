import SwiftUI

struct MusicFilterView: View {
    @State private var allGenres: [MusicGenre] // TODO: - 전체 장르 시드 불러오기
    @State private var selectedGenres: Set<MusicGenre>
    
    init(
        allGenres: [MusicGenre] = MusicGenre.allCases,
        selectedGenres: Set<MusicGenre> = []
    ) {
        self.allGenres = allGenres
        self.selectedGenres = selectedGenres
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text.molioSemiBold("장르", size: 17)
                .foregroundStyle(.white)
            ScrollView {
                TagLayout {
                    ForEach(allGenres, id: \.self) { genre in
                        FilterTag(
                            content: genre.description,
                            isSelected: selectedGenres.contains(genre)
                        ) {
                            toggleSelection(of: genre)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 22)
    }
    
    private func toggleSelection(of genre: MusicGenre) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
    }
}

#Preview {
    ZStack {
        Color.background
        MusicFilterView(selectedGenres: [.acoustic, .blackMetal, .emo, .jDance])
    }
}
