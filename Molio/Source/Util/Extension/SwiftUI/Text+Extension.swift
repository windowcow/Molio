import SwiftUI

// Pretandard 폰트와 자간 적용한 Text
/// 몰리오 앱의 모든 Text는 molio<폰트이름>을 적용해서 사용해주세요. ( 사용예시는 맨 아래를 참고해주세요 )
extension Text {
    static let spacing: CGFloat = -0.5
    
    private static func molioFont(_ content: String, name: String, size: CGFloat) -> Text {
        Text(content)
            .font(.custom(name, size: size))
            .tracking(spacing)
    }
    
    static func molioBlack(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-Black", size: size)
    }
    
    static func molioBold(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-Bold", size: size)
    }
    
    static func molioExtraBold(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-ExtraBold", size: size)
    }
    
    static func molioSemiBold(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-SemiBold", size: size)
    }
    
    static func molioMedium(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-Medium", size: size)
    }
    
    static func molioRegular(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-Regular", size: size)
    }
    
    static func molioThin(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-Thin", size: size)
    }
    
    static func molioLight(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-Light", size: size)
    }
    
    static func molioExtraLight(_ content: String, size: CGFloat) -> Text {
        molioFont(content, name: "Pretendard-ExtraLight", size: size)
    }
}

// 사용 예시
// Text.molioBlack("Black Font", size: 20)
