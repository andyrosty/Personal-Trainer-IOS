import SwiftUI

extension Color {
    // Base colors
    static let terracotta = Color(.systemRed)
    static let mustard    = Color(.systemYellow)
    static let olive      = Color(.systemGreen)
    static let ivory      = Color(.systemBackground)
    static let charcoal   = Color(.label)
    static let slateGray  = Color(.secondaryLabel)

    // Brand colors
    static let brandGreen    = Color(.systemGreen)
    static let progressBlue  = Color(.systemBlue)
    static let accentOrange  = Color(.systemOrange)

    // Semantic colors for dark mode
    static let cardBackground = Color(.secondarySystemBackground)
    static let primaryText = Color(.label)
    static let secondaryText = Color(.secondaryLabel)
    static let buttonText = Color(.systemBackground)

    // Chat colors
    static let userBubble = Color(.systemGreen)
    static let assistantBubble = Color(.secondarySystemBackground)

    // Shadow and effects
    static let shadowColor = Color.black.opacity(0.1)

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
