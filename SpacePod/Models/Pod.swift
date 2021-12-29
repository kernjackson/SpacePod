import Foundation

class Pod: Codable, Identifiable {
    let id: UUID
    let copyright: String?
    let date: Date?
    let explanation: String
    let hdurl: URL?
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: URL?
    let thumbnailUrl: URL?

    private enum CodingKeys: String, CodingKey {
        case id
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

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = UUID()
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
