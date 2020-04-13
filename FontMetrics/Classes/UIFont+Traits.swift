import Foundation
import UIKit

extension UIFont {

    var traitsPresent: String {
        let traits: [String: UIFontDescriptor.SymbolicTraits] = [
            "Bold": .traitBold,
            "Italic": .traitItalic,
            "Condensed": .traitCondensed,
            "Expanded": .traitExpanded,
            "Vertical": .traitVertical,
            "Monospace": .traitMonoSpace,
            "Loose Leading": .traitLooseLeading,
            "Tight Leading": .traitTightLeading,
        ]
        var result: [String] = []
        for trait in traits.keys {
            if self.fontDescriptor.symbolicTraits.contains(traits[trait]!) {
                result.append(trait)
            }
        }
        return result.joined(separator: ",")
    }

    var classesPresent: String {
        let traits: [String: UIFontDescriptor.SymbolicTraits] = [
            "Modern Serifs": .classModernSerifs,
            "Scripts": .classScripts,
            "Symbolic": .classSymbolic,
            "Mask": .classMask,
            "Sans Serif": .classSansSerif,
            "Slab Serifs": .classSlabSerifs,
            "Ornamentals": .classOrnamentals,
            "Free Form Serifs": .classFreeformSerifs,
            "Old Style Serifs": .classOldStyleSerifs,
            "Clarendon Serifs": .classClarendonSerifs,
            "Transitional Serifs": .classTransitionalSerifs,
        ]
        var result: [String] = []
        for trait in traits.keys {
            if self.fontDescriptor.symbolicTraits.contains(traits[trait]!) {
                result.append(trait)
            }
        }
        return result.joined(separator: ",")
    }
}
