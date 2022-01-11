import Foundation
import UIKit

extension FileManager {

    static var getDocumentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    static func loadImage(name: String) -> UIImage? {
        let filename = FileManager.getDocumentsDirectory.appendingPathComponent(name)
        let image = UIImage(contentsOfFile: filename.path)
        log("🗃 loaded \(filename)")
        return image
    }
}
