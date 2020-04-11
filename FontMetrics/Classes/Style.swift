import Foundation
import UIKit
import SwiftUI

struct Style {

    static let digitFont = UIFont.monospacedDigitSystemFont(ofSize: UIFont.labelFontSize, weight: .semibold)

    static let metricFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3
        return formatter
    }()

}

extension UIFont {
    var font: Font {
        return Font(self.CTFontRef)
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ number: NSNumber, formatter: NumberFormatter) {
        if let result = formatter.string(from: number as NSNumber) {
            appendLiteral(result)
        }
    }
}
