import SwiftUI

extension Font {
    enum BarlowCondensedWeight {
        case thin, extraLight, light, regular, medium, semiBold, bold, extraBold, black
        case thinItalic, extraLightItalic, lightItalic, italic, mediumItalic, semiBoldItalic, boldItalic, extraBoldItalic, blackItalic
        
        var value: String {
            switch self {
            case .thin: return "BarlowCondensed-Thin"
            case .extraLight: return "BarlowCondensed-ExtraLight"
            case .light: return "BarlowCondensed-Light"
            case .regular: return "BarlowCondensed-Regular"
            case .medium: return "BarlowCondensed-Medium"
            case .semiBold: return "BarlowCondensed-SemiBold"
            case .bold: return "BarlowCondensed-Bold"
            case .extraBold: return "BarlowCondensed-ExtraBold"
            case .black: return "BarlowCondensed-Black"
            case .thinItalic: return "BarlowCondensed-ThinItalic"
            case .extraLightItalic: return "BarlowCondensed-ExtraLightItalic"
            case .lightItalic: return "BarlowCondensed-LightItalic"
            case .italic: return "BarlowCondensed-Italic"
            case .mediumItalic: return "BarlowCondensed-MediumItalic"
            case .semiBoldItalic: return "BarlowCondensed-SemiBoldItalic"
            case .boldItalic: return "BarlowCondensed-BoldItalic"
            case .extraBoldItalic: return "BarlowCondensed-ExtraBoldItalic"
            case .blackItalic: return "BarlowCondensed-BlackItalic"
            }
        }
    }
    
    static func barlowCondensed(_ weight: BarlowCondensedWeight, size: CGFloat) -> Font {
        return Font.custom(weight.value, size: size)
    }
    
    // Convenience methods for common text styles
    static func barlowCondensedTitle() -> Font {
        return barlowCondensed(.bold, size: 28)
    }
    
    static func barlowCondensedHeadline() -> Font {
        return barlowCondensed(.semiBold, size: 20)
    }
    
    static func barlowCondensedSubheadline() -> Font {
        return barlowCondensed(.medium, size: 16)
    }
    
    static func barlowCondensedBody() -> Font {
        return barlowCondensed(.regular, size: 16)
    }
    
    static func barlowCondensedCaption() -> Font {
        return barlowCondensed(.light, size: 14)
    }
}