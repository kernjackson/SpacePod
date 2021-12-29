import SwiftUI

struct PodListView: View {
    @State var pods: [Pod] = []

    var body: some View {
        NavigationView {

            if let pod = pods.first {
                List {
                    ForEach(pods, id: \.id) { pod in
                        NavigationLink(destination: PodDetailView(pod: pod)) {
                            Text(pod.title)
                        }
                    }
                }
                .navigationTitle("SpacePod")
                .navigationBarTitleDisplayMode(.inline)
                .refreshable {
                    await getPods()
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
            withAnimation {
                pods += response
                pods = pods.reversed()
            }
        }
    }
}

struct PodListView_Previews: PreviewProvider {
    static var pods = File.data(from: "get-pods", withExtension: .json)?.toPods
    static var previews: some View {

        // I've disabled these due to performance issues while screen recording

//        PodListView(pods: [])
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
//            .previewDisplayName("iPhone 13 mini - Fetching Pods...")
//        PodListView(pods: pods!)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
//            .previewDisplayName("iPhone 13 mini")

        PodListView(pods: [])
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewDisplayName("iPad mini - Fetching Pods...")
            .previewInterfaceOrientation(.landscapeRight)

        PodListView(pods: pods!)
            .previewDevice(PreviewDevice(rawValue:  "iPad mini (6th generation)"))
            .previewDisplayName("iPhone 13 mini")
            .previewInterfaceOrientation(.landscapeRight)
    }
}
