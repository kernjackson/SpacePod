import Foundation
import CoreData

class Pod: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdurl
        case mediaType
        case serviceVersion
        case title
        case url
        case thumbnailUrl
    }

    enum DecoderConfigurationError: Error {
        case missingManagedObjectContext
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectText] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        date = try container.decodeIfPresent(Date.self, forKey: .date)
        explanation = try container.decode(String.self, forKey: .explanation)
        hdurl = try container.decodeIfPresent(URL.self, forKey: .hdurl)
        mediaType = try container.decode(String.self, forKey: .mediaType)
        serviceVersion = try container.decode(String.self, forKey: .serviceVersion)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        thumbnailUrl = try container.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
    }
}

extension CodingUserInfoKey {
    static let managedObjectText = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

extension Pod {
    static var recent: NSFetchRequest<Pod> {
        let request: NSFetchRequest<Pod> = Pod.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Pod.date, ascending: false)]
        return request
    }
}
