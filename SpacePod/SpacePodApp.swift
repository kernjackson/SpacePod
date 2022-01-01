import SwiftUI

@main
struct SpacePodApp: App {

    @ObservedObject var podsController = PodsController(managedObjectContext: PersistenceController.shared.container.viewContext)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(podsController)
        }
    }
}
