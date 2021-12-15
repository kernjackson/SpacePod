import Foundation

class Network {

    func getString() async -> String {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-11-07")!
        do {
            let request = URLRequest(url: url)
            let (data, error) = try await URLSession.shared.data(for: request)
            return String(data: data, encoding: .utf8) ?? error.debugDescription
        }
        catch {
            return error.localizedDescription
        }
    }

    func getPod() async -> Pod? {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-11-07")!
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            return data.toPod
        }
        catch {
            return nil
        }
    }

    func getPods() async -> [Pod]? {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=20")!
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            return data.toPods
        }
        catch {
            return nil
        }
    }
}
