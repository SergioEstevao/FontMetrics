import Foundation
import UIKit
import SwiftUI

struct Style {

    static let metricFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3
        return formatter
    }()

}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ number: NSNumber, formatter: NumberFormatter) {
        if let result = formatter.string(from: number as NSNumber) {
            appendLiteral(result)
        }
    }
}
