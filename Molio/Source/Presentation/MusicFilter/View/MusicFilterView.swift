import SwiftUI

struct MusicFilterView: View {
    @State private var selectedGenres: [String]
    
    init(selectedGenres: [String]) {
        self.selectedGenres = selectedGenres
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text.molioSemiBold("장르", size: 17)
                .foregroundStyle(.white)
            ScrollView {
                TagLayout {
                    ForEach(MusicGenre.allCases.map(\.displayName), id: \.self) { genre in
                        FilterTag(content: genre)
                    }
                }
                .background(.red)
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 22)
    }
}

#Preview {
    ZStack {
        Color.background
        MusicFilterView(selectedGenres: MusicFilter.mock.genres)
    }
}
