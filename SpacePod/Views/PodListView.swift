import SwiftUI

struct PodListView: View {

    @EnvironmentObject var pods: PodsController

    var body: some View {
        NavigationView {

            if let pod = pods.fetched.first {
                List {
                    ForEach(pods.fetched, id: \.id) { pod in
                        NavigationLink(destination: PodDetailView(pod: pod)) {
                            Text(pod.title ?? pod.date?.long ?? "")
                        }
                    }
                }
                .navigationTitle("SpacePod")
                .navigationBarTitleDisplayMode(.inline)
                .refreshable {
                    await pods.getPods()
                }
                PodDetailView(pod: pod)

            } else {
                Text("Fetching Pods...")
                Text("Fetching Pods...")
            }
        }
        .task {
            if pods.fetched.isEmpty { await pods.getPods() }
        }
    }
}

struct PodListView_Previews: PreviewProvider {
    static var previews: some View {
        PodListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
