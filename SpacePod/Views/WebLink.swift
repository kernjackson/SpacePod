import SwiftUI

struct WebLink: View {
    var date: Date?

    var body: some View {
        if let url = date?.webUrl {
            Link(destination: url) {
                Label("Open in Safari", systemImage: "safari.fill")
                    .symbolRenderingMode(.hierarchical)
            }
        }
    }
}

struct WebLink_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section(header: Text("Today")) { WebLink(date: Date()) }
            Section(header: Text("NIL")) { WebLink() }
        }
    }
}
