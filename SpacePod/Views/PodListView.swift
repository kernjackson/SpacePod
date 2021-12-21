import SwiftUI

struct PodListView: View {
    @State var pods: [Pod] = []

    var body: some View {
        NavigationView {

            if let pod = pods.first {
                List {
                    ForEach(pods, id: \.self) { pod in
                        NavigationLink(destination: PodDetailView(pod: pod)) {
                            Text(pod.title)
                        }
                    }
                    .navigationTitle("SpacePod")
                    .navigationBarTitleDisplayMode(.inline)
                    .refreshable {
                        await getPods()
                    }
                }
                PodDetailView(pod: pod)

            } else {
                Text("Fetching Pods...")
                Text("Fetching Pods...")
            }

        }
        .task {
            if pods.isEmpty { await getPods() }
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

        PodListView(pods: [])
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
            .previewDisplayName("iPhone 13 mini: Loading")
            .previewInterfaceOrientation(.landscapeRight)
        PodListView(pods: pods!)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
            .previewDisplayName("iPhone 13 mini")
            .previewInterfaceOrientation(.landscapeRight)

        PodListView(pods: [])
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewDisplayName("iPhone 13 mini: Loading")
            .previewInterfaceOrientation(.landscapeRight)
        PodListView(pods: pods!)
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewDisplayName("iPhone 13 mini")
            .previewInterfaceOrientation(.landscapeRight)
    }
}
