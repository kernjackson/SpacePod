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
                                delete(pod)
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
                        Button("GET Old") { Task { await getOld() } }
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
            if pods.isEmpty { await getNew() }
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
                save()
            }
        }
    }

    private func getOld() async {
        guard let to = pods.last?.date?.previous(1) else { return }
        let from = to.previous(30)
        if await Network().getPods(from, to) != nil {
            save()
        }
    }
}

// MARK: - CoreData

extension PodListView {
    private func delete(_ pod: Pod) {
        viewContext.delete(pod)
        save()
    }

    private func save() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
