import SwiftUI

// Pretandard 폰트와 자간 적용한 Image
/// 몰리오 앱의 모든 Image는 molio<폰트이름>을 적용해서 사용해주세요. ( 사용예시는 맨 아래를 참고해주세요 )
extension Image {
    private static func molioFont(_ systemName: String, name: String, size: CGFloat, color: Color) -> some View {
        Image(systemName: systemName)
            .font(.custom(name, size: size))
            .foregroundStyle(color)
    }
    
    static func molioBlack(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.Black, size: size, color: color)
    }
    
    static func molioBold(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.Bold, size: size, color: color)
    }
    
    static func molioExtraBold(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.ExtraBold, size: size, color: color)
    }
    
    static func molioSemiBold(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.SemiBold, size: size, color: color)
    }
    
    static func molioMedium(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.Medium, size: size, color: color)
    }
    
    static func molioRegular(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.Regular, size: size, color: color)
    }
    
    static func molioThin(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.Thin, size: size, color: color)
    }
    
    static func molioLight(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.Light, size: size, color: color)
    }
    
    static func molioExtraLight(systemName: String, size: CGFloat, color: Color) -> some View {
        molioFont(systemName, name: PretendardFontName.ExtraLight, size: size, color: color)
    }
}

// 사용 예시
// Image.molioBlack("Black Font", size: 20)
