import SwiftUI

struct FilterCell: View {
    private let content: String
    private let fontSize: CGFloat
    private let cornerRadius: CGFloat
    private let verticalPadding: CGFloat
    private let horizontalPadding: CGFloat
    @State private var isEditing: Bool
    @State private var isSelected: Bool
    
    init(
        content: String,
        fontSize: CGFloat = 14,
        cornerRadius: CGFloat = 8,
        verticalPadding: CGFloat = 6,
        horizontalPadding: CGFloat = 10,
        isEditing: Bool = false,
        isSelected: Bool = true
    ) {
        self.content = content
        self.fontSize = fontSize
        self.cornerRadius = cornerRadius
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.isEditing = isEditing
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack(spacing: 7) {
            Text.molioMedium(content, size: fontSize)
                .foregroundStyle(isSelected ? .white : .gray)
            if isEditing {
                Image.molioSemiBold(systemName: "x.circle.fill", size: 14, color: Color.background)
            }
        }
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
        .background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(isSelected ? Color.tag : .clear)
        }
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(isSelected ? .clear : .gray, lineWidth: 1)
        }
    }
}

#Preview {
    ZStack {
        Color.background
        VStack {
            FilterCell(
                content: "블랙핑크",
                isEditing: false,
                isSelected: true
            )
            FilterCell(
                content: "블랙핑크",
                isEditing: true,
                isSelected: true
            )
            FilterCell(
                content: "블랙핑크",
                isEditing: false,
                isSelected: false
            )
        }
    }
}
