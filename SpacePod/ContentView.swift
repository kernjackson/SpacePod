import SwiftUI

struct ContentView: View {
    @State var text = "Hello, space!"
    var body: some View {
        Text(text)
            .padding()
            .task {
                text = await Network().getString()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Network {

    let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!

    func getString() async -> String {
        do {
            let request = URLRequest(url: url)
            let (data, error) = try await URLSession.shared.data(for: request)
            return String(data: data, encoding: .utf8) ?? error.debugDescription
        }
        catch {
            return error.localizedDescription
        }
    }
}
