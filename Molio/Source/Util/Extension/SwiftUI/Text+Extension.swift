import SwiftUI

// Pretandard 폰트와 자간 적용한 Text
/// 몰리오 앱의 모든 Text는 molio<폰트이름>을 적용해서 사용해주세요. ( 사용예시는 맨 아래를 참고해주세요 )
extension Text {
    static let spacing: CGFloat = -0.5
    
    static func molioBlack(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardBlack(size: size))
            .tracking(spacing)
    }
    
    static func molioBold(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardBold(size: size))
            .tracking(spacing)
    }
    
    static func molioExtraBold(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardExtraBold(size: size))
            .tracking(spacing)
    }
    
    static func molioSemiBold(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardSemiBold(size: size))
            .tracking(spacing)
    }
    
    static func molioMedium(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardMedium(size: size))
            .tracking(spacing)
    }
    
    static func molioRegular(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardRegular(size: size))
            .tracking(spacing)
    }
    
    static func molioThin(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardThin(size: size))
            .tracking(spacing)
    }
    
    static func molioLight(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardLight(size: size))
            .tracking(spacing)
    }
    
    static func molioExtraLight(_ content: String, size: CGFloat) -> Text {
        Text(content)
            .font(.pretendardExtraLight(size: size))
            .tracking(spacing)
    }
}

// 사용 예시
//struct ContentView: View {
//    var body: some View {
//        VStack(spacing: 20) {
//            Text.molioBlack("Black Font", size: 20)
//            Text.molioBold("Bold Font", size: 20)
//            Text.molioExtraBold("Extra Bold Font", size: 20)
//            Text.molioSemiBold("SemiBold Font", size: 20)
//            Text.molioMedium("Medium Font", size: 20)
//            Text.molioRegular("Regular Font", size: 20)
//            Text.molioThin("Thin Font", size: 20)
//            Text.molioLight("Light Font", size: 20)
//            Text.molioExtraLight("Extra Light Font", size: 20)
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
