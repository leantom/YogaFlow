import SwiftUI

enum YogaFlowTheme {
    static let background = Color(hex: "FFFFFF")
    static let mintBackground = Color(hex: "F3FCF3")
    static let mintSoft = Color(hex: "D4FAE8")
    static let mintSurface = Color(hex: "ECFFF7")
    static let brand = Color(hex: "18E299")
    static let brandDeep = Color(hex: "007A51")
    static let ink = Color(hex: "0D0D0D")
    static let textSecondary = Color(hex: "333333")
    static let textTertiary = Color(hex: "666666")
    static let border = Color.black.opacity(0.06)
    static let destructive = Color(hex: "D45656")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let red: UInt64
        let green: UInt64
        let blue: UInt64

        switch hex.count {
        case 6:
            (red, green, blue) = ((int >> 16) & 0xff, (int >> 8) & 0xff, int & 0xff)
        default:
            (red, green, blue) = (0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: 1
        )
    }
}
