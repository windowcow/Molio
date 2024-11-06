import SwiftUI

// 프리텐다드 폰트
/// 폰트 그대로 사용하지 마세요. Text+Extension을 참고하세요.
extension Font {
    static func pretendardBlack(size: CGFloat) -> Font {
        .custom(PretendardFontName.Black, size: size)
    }
    static func pretendardBold(size: CGFloat) -> Font {
        .custom(PretendardFontName.Bold, size: size)
    }
    static func pretendardExtraBold(size: CGFloat) -> Font {
        .custom(PretendardFontName.ExtraBold, size: size)
    }
    static func pretendardSemiBold(size: CGFloat) -> Font {
        .custom(PretendardFontName.SemiBold, size: size)
    }
    static func pretendardMedium(size: CGFloat) -> Font {
        .custom(PretendardFontName.Medium, size: size)
    }
    static func pretendardRegular(size: CGFloat) -> Font {
        .custom(PretendardFontName.Regular, size: size)
    }
    static func pretendardThin(size: CGFloat) -> Font {
        .custom(PretendardFontName.Thin, size: size)
    }
    static func pretendardLight(size: CGFloat) -> Font {
        .custom(PretendardFontName.Light, size: size)
    }
    static func pretendardExtraLight(size: CGFloat) -> Font {
        .custom(PretendardFontName.ExtraLight, size: size)
    }
}
