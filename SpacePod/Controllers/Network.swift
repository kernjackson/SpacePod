import Foundation
import UIKit

struct url {
    static let api = "https://api.nasa.gov/planetary/apod"
    static let web = "https://apod.nasa.gov/apod/ap"
}

class Network {

    static let shared = Network()

    let apiKey = "?api_key=" + (File.data(from: "Secrets", withExtension: .json)?.toSecret?.apiKey.description ?? "DEMO_KEY")
    let count = "&count=" + "20"
    let thumbs = "&thumbs=" + "true"

    func getPods(_ from: Date, _ to: Date) async -> [Pod]? {
        let start = "&start_date=" + from.yyyy_MM_dd
        let end = "&end_date=" + to.yyyy_MM_dd
        let url = URL(string: "\(url.api)\(apiKey)\(start)\(end)\(thumbs)")!
        do {
            let request = URLRequest(url: url)
            log("🌎 request: " + request.debugDescription)
            let (data, response) = try await URLSession.shared.data(for: request)
            log("🌎 response: " + response.debugDescription)
            return data.toPods
        }
        catch {
            log("🌎 error: " + error.localizedDescription)
            return nil
        }
    }

    func getImage(url: URL) async -> UIImage? {
        do {
            let request = URLRequest(url: url)
            log("🌎 request: " + request.debugDescription)
            let (data, response) = try await URLSession.shared.data(for: request)
            log("🌎 response: " + response.debugDescription)
            return UIImage(data: data)
        }
        catch {
            log("🌎 error: " + error.localizedDescription)
            return nil
        }
    }

    private func log(_ string: String) {
#if DEBUG
        print(string.replacingOccurrences(of: apiKey, with: "?api_key=" + "YOUR_OBFUSCATED_API_KEY"))
#endif
    }
}

func log(_ string: String) {
#if DEBUG
    print(string)
#endif
}
