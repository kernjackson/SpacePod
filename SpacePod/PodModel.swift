import Foundation

struct Pod: Codable {
    let copyright: String?
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

extension Pod {
    static let `default` = Pod(
      copyright: "Andrew McCarthy",
      date: "2021-12-06",
      explanation: "What's that unusual spot on the Moon? It's the International Space Station. Using precise timing, the Earth-orbiting space platform was photographed in front of a partially lit gibbous Moon last month. The featured composite, taken from Payson, Arizona, USA last month, was intricately composed by combining, in part, many 1/2000-second images from a video of the ISS crossing the Moon. A close inspection of this unusually crisp ISS silhouette will reveal the outlines of numerous solar panels and trusses.  The bright crater Tycho is visible on the upper left, as well as comparatively rough, light colored terrain known as highlands, and relatively smooth, dark colored areas known as maria.  On-line tools can tell you when the International Space Station will be visible from your area.",
      hdurl: URL(string: "https://apod.nasa.gov/apod/image/2112/IssMoon_McCarthy_1663.jpg")!,
      mediaType: "image",
      serviceVersion: "v1",
      title: "Space Station Silhouette on the Moon",
      url: URL(string: "https://apod.nasa.gov/apod/image/2112/IssMoon_McCarthy_960.jpg")!
    )
}
