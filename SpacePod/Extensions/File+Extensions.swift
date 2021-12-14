import Foundation

class File {

    enum FileExtension: String {
        case json = "json"
    }

    static func data(from path: String, withExtension: FileExtension? = .none) -> Data? {
        guard let url = Bundle.main.url(forResource: path, withExtension: withExtension?.rawValue) else { return nil }
        return try? Data(contentsOf: url)
    }
}
