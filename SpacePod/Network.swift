import Foundation

class Network {

    let baseUrl = "https://api.nasa.gov/planetary/apod"
    let apiKey = "?api_key=" + (File.data(from: "Secrets", withExtension: .json)?.toSecret?.apiKey.description ?? "DEMO_KEY")

    func getPods() async -> [Pod]? {
        let url = URL(string: "\(baseUrl)\(apiKey)&count=20")!
        do {
            let request = URLRequest(url: url)
#if DEBUG
            print("🌎 request: " + request.debugDescription)
#endif
            let (data, response) = try await URLSession.shared.data(for: request)
#if DEBUG
            print("🌎 response: " + response.debugDescription)
#endif
            return data.toPods
        }
        catch {
#if DEBUG
            print("🌎 error: " + error.localizedDescription)
#endif
            return nil
        }
    }
}
