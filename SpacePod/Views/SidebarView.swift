import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            NavigationLink {
                PodListView()
            } label: {
                Label("Recent", systemImage: "clock")
            }
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SidebarView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
