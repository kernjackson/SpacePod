import Foundation
import SwiftUI

extension UIImage {

    func saveJPG(name: String) {
        if let data = self.jpegData(compressionQuality: 1.0) {
            let filename = FileManager.getDocumentsDirectory.appendingPathComponent(name)
            log("🗃 saved \(filename)")
            try? data.write(to: filename)
        }
    }
}
