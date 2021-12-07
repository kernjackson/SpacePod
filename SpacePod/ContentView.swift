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
