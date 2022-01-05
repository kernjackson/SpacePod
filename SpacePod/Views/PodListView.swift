import SwiftUI

// MARK: - View

struct PodListView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Pod.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)],
                  predicate: nil,
                  animation: .default)
    var pods: FetchedResults<Pod>

    var body: some View {
        NavigationView {

            if let pod = pods.first {
                List {
                    ForEach(pods, id: \.id) { pod in
                        NavigationLink(destination: PodDetailView(pod: pod)) {
                            Text(pod.title ?? pod.date?.long ?? "")
                        }
#if DEBUG
                        .swipeActions {
                            Button {
                                PersistenceController.shared.delete(pod)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)

                        }
#endif
                    }
#if DEBUG
                    Section {
                        Button("GET New") { Task { await getNew() } }
                        Button("GET Old") { Task { await getMore() } }
                    }
#endif
                }
                .navigationTitle("SpacePod")
                .navigationBarTitleDisplayMode(.inline)
                .refreshable {
                    await getNew()
                }
                PodDetailView(pod: pod)

            } else {
                Text("Fetching Pods...")
                Text("Fetching Pods...")
            }
        }
        .task {
            if pods.isEmpty { await getMore() }
        }
    }
}

// MARK: - Preview
struct PodListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


// MARK: - Network

extension PodListView {
    private func getNew() async {
        guard let from = pods.first?.date else { return }
        let to = Date()
        let compare = Calendar.current.compare(from, to: to, toGranularity: .day)
        if compare == .orderedAscending {
            if await Network().getPods(from, to) != nil {
                PersistenceController.shared.save()
            }
        }
    }

    private func getMore() async {
        let to = pods.last?.date?.previous(1) ?? Date()
        let from = to.previous(30)
        if await Network().getPods(from, to) != nil {
            PersistenceController.shared.save()
        }
    }
}
