import SwiftUI

extension Color {
    static let terracotta = Color(hex: "E07A5F")
    static let mustard    = Color(hex: "F2CC8F")
    static let olive      = Color(hex: "81B29A")
    static let ivory      = Color(hex: "F4F1DE")
    static let charcoal   = Color(hex: "3D405B")
    static let slateGray  = Color(hex: "6D6875")

    /// Initialize from a hex string, e.g. "E07A5F"
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
