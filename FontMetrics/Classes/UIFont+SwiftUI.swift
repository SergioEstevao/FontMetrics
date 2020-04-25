import Foundation
import UIKit
import SwiftUI

extension Font {
    static func custom(_ font: UIFont, style: UIFont.TextStyle) -> Font {
        return Font.custom(font.fontName, size: UIFont.preferredFont(forTextStyle: style).pointSize)
    }
}

extension UIFont.TextStyle {

    var fontStyle: Font.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .caption1: return .caption
        case .caption2: return .caption
        case .footnote: return .footnote
        case .title1: return .title
        case .title2: return .title
        case .title2: return .title
        default:
            return .body
        }
    }
}
