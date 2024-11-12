import UIKit

extension UIColor {
    
    convenience init?(hex: String) {
        let red, green, blue: CGFloat
        
        let start = hex.hasPrefix("#") ? hex.index(hex.startIndex, offsetBy: 1) : hex.startIndex
        let hexColor = String(hex[start...])
        
        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexNumber & 0x0000FF) / 255.0
                
                self.init(red: red, green: green, blue: blue, alpha: 1.0)
                return
            }
        }
        
        return nil
    }
    
    convenience init(rgbaColor: RGBAColor) {
        self.init(red: rgbaColor.red,
                  green: rgbaColor.green,
                  blue: rgbaColor.blue,
                  alpha: rgbaColor.alpha
        )
    }
}
