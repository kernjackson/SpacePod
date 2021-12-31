import SwiftUI

struct PodListView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Pod.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var pods: FetchedResults<Pod>

    var body: some View {
        NavigationView {

            if let pod = pods.first {
                List {
                    ForEach(pods, id: \.id) { pod in
                        NavigationLink(destination: PodDetailView(pod: pod)) {
                            Text(pod.title ?? pod.date?.long ?? "")
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
        if await Network().getPods() != nil {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct PodListView_Previews: PreviewProvider {
    static var previews: some View {
        PodListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
