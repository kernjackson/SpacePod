import Foundation
import CoreData

class PodsController: NSObject, ObservableObject {

    @Published var fetched: [Pod] = []
    private let podsController: NSFetchedResultsController<Pod>

    init(managedObjectContext: NSManagedObjectContext) {
        podsController = NSFetchedResultsController(fetchRequest: Pod.recent, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        super.init()

        podsController.delegate = self

        do {
            try podsController.performFetch()
        } catch {
            print("failed to fetch items!")
        }
    }

    func getPods() async {
        if await Network().getPods() != nil {
            do {
                try podsController.managedObjectContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

extension PodsController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedObjects = controller.fetchedObjects as? [Pod] else { return }
        fetched = fetchedObjects
    }
}
