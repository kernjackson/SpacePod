import SwiftUI

struct ContentView: View {
    @State var pod = Pod.default
    var body: some View {
        List {
            AsyncImage(url: pod.url)
                .frame(height: 280)
                .listRowInsets(.init())
            Text(pod.title)
                .font(.title)
                .bold()
                .padding(.vertical)
            if let copyright = pod.copyright {
                Label(copyright, systemImage: "c.circle.fill")
            }
            Label(pod.date, systemImage: "calendar")
            Text(pod.explanation)
                .padding(.vertical)
        }.task {
            if let response = await Network().getPod() {
                pod = response
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
