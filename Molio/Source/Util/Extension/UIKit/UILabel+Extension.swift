import UIKit

// Pretandard 폰트와 자간 적용한 UILabel
/// 몰리오 앱의 모든 UILabel는 molio<폰트이름>을 적용해서 사용해주세요. ( 사용예시는 맨 아래를 참고해주세요 )
extension UILabel {
    static let letterSpacing: CGFloat = -0.5
    
    func applyMolioFont(name: String, size: CGFloat) {
        let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.kern, value: UILabel.letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    
    func molioBlack(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-Black", size: size)
    }
    
    func molioBold(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-Bold", size: size)
    }
    
    func molioExtraBold(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-ExtraBold", size: size)
    }
    
    func molioSemiBold(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-SemiBold", size: size)
    }
    
    func molioMedium(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-Medium", size: size)
    }
    
    func molioRegular(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-Regular", size: size)
    }
    
    func molioThin(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-Thin", size: size)
    }
    
    func molioLight(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-Light", size: size)
    }
    
    func molioExtraLight(text: String, size: CGFloat) {
        self.text = text
        self.applyMolioFont(name: "Pretendard-ExtraLight", size: size)
    }
}

// 사용 예시
//import SwiftUI
//
//struct LabelPreview: UIViewRepresentable {
//    let text: String
//    let fontName: String
//    let fontSize: CGFloat
//    
//    func makeUIView(context: Context) -> UILabel {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.applyMolioFont(name: fontName, size: fontSize) // 확장한 폰트 메서드 사용
//        return label
//    }
//    
//    func updateUIView(_ uiView: UILabel, context: Context) {
//        uiView.text = text
//        uiView.applyMolioFont(name: fontName, size: fontSize)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(spacing: 20) {
//            LabelPreview(text: "Black Font", fontName: PretendardFontName.Black, fontSize: 20)
//            LabelPreview(text: "Bold Font", fontName: PretendardFontName.Bold, fontSize: 20)
//            LabelPreview(text: "Extra Bold Font", fontName: PretendardFontName.ExtraBold, fontSize: 20)
//            LabelPreview(text: "SemiBold Font", fontName: PretendardFontName.SemiBold, fontSize: 20)
//            LabelPreview(text: "Medium Font", fontName: PretendardFontName.Medium, fontSize: 20)
//            LabelPreview(text: "Regular Font", fontName: PretendardFontName.Regular, fontSize: 20)
//            LabelPreview(text: "Thin Font", fontName: PretendardFontName.Thin, fontSize: 20)
//            LabelPreview(text: "Light Font", fontName: PretendardFontName.Light, fontSize: 20)
//            LabelPreview(text: "Extra Light Font", fontName: PretendardFontName.ExtraLight, fontSize: 20)
//        }
//        .padding()
//    }
//}
