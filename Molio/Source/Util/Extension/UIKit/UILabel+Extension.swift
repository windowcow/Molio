import UIKit

// Pretendard 폰트와 자간 적용한 UILabel
/// 몰리오 앱의 모든 UILabel는 molio<폰트이름>을 적용해서 사용해주세요. ( 사용예시는 맨 아래를 참고해주세요 )
extension UILabel {
    static let letterSpacing: CGFloat = -0.5
    
    private func applyFont(name: String, size: CGFloat, text: String) {
        let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([
            .font: font,
            .kern: UILabel.letterSpacing
        ], range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    
    func molioBlack(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.Black, size: size, text: text)
    }
    
    func molioBold(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.Bold, size: size, text: text)
    }
    
    func molioExtraBold(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.ExtraBold, size: size, text: text)
    }
    
    func molioSemiBold(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.SemiBold, size: size, text: text)
    }
    
    func molioMedium(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.Medium, size: size, text: text)
    }
    
    func molioRegular(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.Regular, size: size, text: text)
    }
    
    func molioThin(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.Thin, size: size, text: text)
    }
    
    func molioLight(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.Light, size: size, text: text)
    }
    
    func molioExtraLight(text: String, size: CGFloat) {
        applyFont(name: PretendardFontName.ExtraLight, size: size, text: text)
    }
}

// 사용 예시
// let label = UILabel()
// label.molioBold(text: "Bold Font", size: 20)
