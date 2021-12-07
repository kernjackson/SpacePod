import Foundation

struct Pod: Codable {
    let copyright: String
    let date: String
    let explanation: String
    let hdurl: URL
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: URL

    private enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
}
