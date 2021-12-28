import Foundation

class Network {

    let baseUrl = "https://api.nasa.gov/planetary/apod"
    let apiKey = "?api_key=" + (File.data(from: "Secrets", withExtension: .json)?.toSecret?.apiKey.description ?? "DEMO_KEY")
    let count = "&count=20"
    let thumbs = "&thumbs=true"

    func getPods() async -> [Pod]? {
        let url = URL(string: "\(baseUrl)\(apiKey)\(count)\(thumbs)")!
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

    private func log(_ string: String) {
#if DEBUG
        print(string.replacingOccurrences(of: apiKey, with: "?api_key=" + "YOUR_OBFUSCATED_API_KEY"))
#endif
    }
}