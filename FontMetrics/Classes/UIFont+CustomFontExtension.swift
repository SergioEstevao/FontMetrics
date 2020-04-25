import Foundation
import UIKit

extension UIFont {

    convenience init?(ctFont: CTFont) {
        let fontName = CTFontCopyPostScriptName(ctFont) as String
        let size = CTFontGetSize(ctFont)
        self.init(name: fontName, size: size)
    }

    var CTFontRef: CTFont {
        let ctFont = CTFontCreateWithName(fontName as CFString, pointSize, nil)
        return ctFont
    }

    convenience init?(url: URL, size: CGFloat) throws {
        let data = try Data(contentsOf: url, options: .uncached)
        let fontName = try UIFont.registerFontFrom(data: data)
        self.init(name: fontName, size: size)
    }

    static func registerFontFrom(data: Data) throws -> String {
        guard
            let provider = CGDataProvider(data: data as CFData)
        else {
            return ""
        }
        let cgFont = CGFont(provider)

        var localError: Unmanaged<CFError>?
        guard
             CTFontManagerRegisterGraphicsFont(cgFont!, &localError),
             let fontName = cgFont?.postScriptName as String?
        else {
            throw localError!.takeRetainedValue()
        }
        return fontName
    }

    static func unregisterFont(named: String) throws -> Bool {
        var localError: Unmanaged<CFError>?
        guard
            let cgFont = CGFont(named as CFString),
            CTFontManagerUnregisterGraphicsFont(cgFont, &localError)
        else {
            if let error = localError {
                throw error.takeRetainedValue()
            }
            return false
        }
        return true
    }

    static var downloadableFonts: [UIFontDescriptor] {
        let descriptorOptions: [String: Any] = [kCTFontDownloadableAttribute as String: true]
        let descriptor = CTFontDescriptorCreateWithAttributes(descriptorOptions as CFDictionary)
        if  let fontDescriptors = CTFontDescriptorCreateMatchingFontDescriptors(descriptor, nil),
            let result = fontDescriptors as? [UIFontDescriptor] {
            return result
        }
        return []
    }

    static func downloadFontFromDescriptor(fontDescriptor: UIFontDescriptor) -> Bool {
        return CTFontDescriptorMatchFontDescriptorsWithProgressHandler([fontDescriptor] as CFArray, nil, {(state, progressParameter) in
            return true
        })
    }

    static var fontFamilies: [String: [String]] {
        get {
            var result = [String: [String]]()
            result = familyNames.reduce(into: result) { (result, fontFamilyName) in
                result[fontFamilyName] = UIFont.fontNames(forFamilyName: fontFamilyName)
            }
            return result
        }
    }

}
