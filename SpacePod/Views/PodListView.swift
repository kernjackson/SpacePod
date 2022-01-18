import SwiftUI

// MARK: - View

struct PodListView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Pod.recent, animation: .default)
    var pods: FetchedResults<Pod>

    var body: some View {
        List {
            ForEach(pods, id: \.id) { pod in
                PodDetailView(pod: pod)
            }
            loadingView
        }
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            await getNewest()
        }
    }

    var loadingView: some View {
        HStack {
            ProgressView()
            Text(" Fetching Pods...")
        }
        .task {
            await getMore()
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
    private func getNewest() async {
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
        let from = to.previous(10)
        if await Network().getPods(from, to) != nil {
            PersistenceController.shared.save()
        }
    }
}
