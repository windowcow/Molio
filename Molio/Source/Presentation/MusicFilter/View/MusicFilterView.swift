import SwiftUI

struct MusicFilterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedGenres: [String]
    
    init(selectedGenres: [String]) {
        self.selectedGenres = selectedGenres
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                print("장르 클릭")
            } label: {
                HStack {
                    Text.molioSemiBold("장르", size: 17)
                        .tint(.white)
                    Image.molioSemiBold(systemName: "chevron.right", size: 14, color: .gray)
                }
            }
            TagLayout {
                ForEach(selectedGenres, id: \.self) { genre in
                    FilterTag(content: genre)
                }
            }
            Spacer()
        }
        .padding(.top, 24)
        .padding(.horizontal, 22)
    }
}

#Preview {
    ZStack {
        Color.background
        MusicFilterView(selectedGenres: MusicFilter.mock.genres)
    }
}
