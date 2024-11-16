import SwiftUI

struct FilterTag: View {
    private let content: String
    private let fontSize: CGFloat
    private let cornerRadius: CGFloat
    private let verticalPadding: CGFloat
    private let horizontalPadding: CGFloat
    private let isEditing: Bool
    private let isSelected: Bool
    
    private let tapAction: () -> Void
    
    init(
        content: String,
        fontSize: CGFloat = 14,
        cornerRadius: CGFloat = 8,
        verticalPadding: CGFloat = 6,
        horizontalPadding: CGFloat = 10,
        isEditing: Bool = false,
        isSelected: Bool = true,
        tapAction: @escaping () -> Void = {}
    ) {
        self.content = content
        self.fontSize = fontSize
        self.cornerRadius = cornerRadius
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.isEditing = isEditing
        self.isSelected = isSelected
        self.tapAction = tapAction
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
        .onTapGesture {
            tapAction()
        }
    }
}

#Preview {
    ZStack {
        Color.background
        VStack {
            FilterTag(
                content: "블랙핑크",
                isEditing: false,
                isSelected: true
            )
            FilterTag(
                content: "블랙핑크",
                isEditing: true,
                isSelected: true
            )
            FilterTag(
                content: "블랙핑크",
                isEditing: false,
                isSelected: false
            )
        }
    }
}
