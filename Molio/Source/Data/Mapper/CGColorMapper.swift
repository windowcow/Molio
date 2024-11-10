import CoreGraphics

struct CGColorMapper {
    static func toDomain(_ cgColor: CGColor?) -> RGBAColor? {
        guard let cgColor = cgColor,
              cgColor.colorSpace?.model == .rgb,
              let components = cgColor.components,
              components.count >= 4 else {
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
