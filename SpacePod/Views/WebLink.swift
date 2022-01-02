import SwiftUI

/// Links to the web page for the given Pod or nil
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
            WebLink()
            WebLink(date: Date())
        }
    }
}
