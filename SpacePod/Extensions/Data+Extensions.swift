import Foundation

extension Data {

    var toPod: Pod? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.userInfo[CodingUserInfoKey.managedObjectText] = PersistenceController.shared.container.viewContext
        decoder.dateDecodingStrategy = .yyyyMMdd
        return try? decoder.decode(Pod?.self, from: self)
    }

    var toPods: [Pod]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.userInfo[CodingUserInfoKey.managedObjectText] = PersistenceController.shared.container.viewContext
        decoder.dateDecodingStrategy = .yyyyMMdd
        return try? decoder.decode([Pod]?.self, from: self)
    }

    var toSecret: Secret? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .yyyyMMdd
        return try? decoder.decode(Secret?.self, from: self)
    }
}
