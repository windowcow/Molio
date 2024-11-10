import CoreGraphics

struct CGColorMapper {
    static func toDomain(_ cgColor: CGColor) -> RGBAColor? {
        guard let components = cgColor.components,
              components.count >= 4,
              cgColor.colorSpace?.model == .rgb else {
            return nil
        }
        
        return RGBAColor(
            red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3]
        )
    }
}
