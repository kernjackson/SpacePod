import Foundation

extension Data {
    var toPod: Pod? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Pod?.self, from: self)
    }
}
