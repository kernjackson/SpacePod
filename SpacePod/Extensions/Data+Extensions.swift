import Foundation

extension Data {

    var toPod: Pod? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(Pod?.self, from: self)
    }

    var toPods: [Pod]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode([Pod]?.self, from: self)
    }
}
