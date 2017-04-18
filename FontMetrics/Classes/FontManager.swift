import Foundation
import UIKit

class FontManager {

    static let downloadedFonts = "DownloadedFonts"

    var fontsDownloaded = [String: String]()

    static let shared = FontManager()

    init() {
        loadFonts()
    }

    private func loadFonts() {
        guard let dict = UserDefaults.standard.object(forKey: FontManager.downloadedFonts) as? [String:String] else {
            return
        }
        fontsDownloaded = dict
        for (fontName, fileName) in fontsDownloaded {
            guard
                let fontURL = FontManager.fontFolder()?.appendingPathComponent(fileName),
                let data = try? Data(contentsOf: fontURL, options: .uncached)
            else {
                fontsDownloaded.removeValue(forKey: fontName)
                continue
            }
            let _ = try? UIFont.registerFontFrom(data:data)
        }
    }

    @discardableResult func addFont(fromURL url: URL) throws -> String {

        let data = try Data(contentsOf:url, options:.uncached)

        let name = try UIFont.registerFontFrom(data:data)

        guard let baseFolder = FontManager.fontFolder() else {
            return ""
        }

        let fileName = uniqueFilename(withPrefix: name, andExtension: "ttf")
        let fontPath = baseFolder.appendingPathComponent(fileName)
        try data.write(to: fontPath, options:[.atomic])

        fontsDownloaded[name] = fileName

        // save it to userDefaults
        UserDefaults.standard.set(fontsDownloaded, forKey: FontManager.downloadedFonts)
        UserDefaults.standard.synchronize()
        return name
    }

    @discardableResult func removeFont(withName name: String) throws -> Bool {
        guard
            let urlPath = fontsDownloaded[name],
            let url = URL(string: urlPath)
        else {
            return false
        }
        try? FileManager.default.removeItem(at: url)
        fontsDownloaded.removeValue(forKey: name)
        let _ = try UIFont.unregisterFont(named: name)

        // save it to userDefaults
        UserDefaults.standard.set(fontsDownloaded, forKey:FontManager.downloadedFonts)
        UserDefaults.standard.synchronize()
        return true
    }

    func isUserFont(withName name: String) -> Bool {
        return fontsDownloaded[name] != nil
    }

    //MARK: - folder helper methods

    private static func fontFolder() -> URL? {
        let possibleURLs = FileManager.default.urls(for:.documentDirectory,
                                                    in:[.userDomainMask])
        guard let documentsDirectory = possibleURLs.first
            else {
                return nil
        }

        let fontsFolder = documentsDirectory.appendingPathComponent(downloadedFonts, isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: fontsFolder, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return nil
        }
        return fontsFolder
    }

    private func uniqueFilename(withPrefix prefix: String, andExtension extension: String) -> String {
        let guid = ProcessInfo.processInfo.globallyUniqueString
        let uniqueFileName = "\(prefix)_\(guid).\(`extension`)"

        return  uniqueFileName
    }

}
