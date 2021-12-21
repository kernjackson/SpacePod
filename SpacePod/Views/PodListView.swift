import SwiftUI

struct PodListView: View {
    @State var pods: [Pod] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(pods, id: \.self) { pod in
                    NavigationLink(destination: PodDetailView(pod: pod)) {
                        Text(pod.title)
                    }
                }
            }
            .navigationTitle(pods.isEmpty ? "Fetching Pods..." : "SpacePod")
            .task {
                if pods.isEmpty { await getPods() }
            }
            .refreshable {
                await getPods()
            }
        }
    }

    private func getPods() async {
        if let response = await Network().getPods() {
            pods = response
        }
    }
}

struct PodListView_Previews: PreviewProvider {
    static var pods = File.data(from: "get-pods", withExtension: .json)?.toPods
    static var previews: some View {
        PodListView(pods: pods!)
    }
}