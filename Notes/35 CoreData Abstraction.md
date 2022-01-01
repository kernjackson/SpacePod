# SpacePod 35 CoreData Abstraction

Our PodListView and CoreData are tightly coupled. Let's create a Pods Controller that to handle networking and persistence.

## Steps

1. Move FetchRequest to Pod+Extension
2. Create an Observable NSObject Pods as `Pods.swift`
3. @Published array `fetched`: [Pod]
4. Conform to `NSFetchedResultsControllerDelegate`
5. init and set self as delegate
6. Move `getPods` from view to Pods `if pods.fetched.isEmpty { await pods.getPods() }`
7. Update PodListView to use `pods.fetched`

### Pod

```swift
// Step 1
extension Pod {
    static var recent: NSFetchRequest<Pod> {
        let request: NSFetchRequest<Pod> = Pod.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        return request
    }
}
```

### Pods

```swift
// Step 2
import Foundation
import CoreData

class PodsController: NSObject, ObservableObject {

    @Published var fetched: [Pod] = []
    private let podsController: NSFetchedResultsController<Pod>

// Step 5
    init(managedObjectContext: NSManagedObjectContext) {
        podsController = NSFetchedResultsController(fetchRequest: Pod.recent,
                                                    managedObjectContext: managedObjectContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)

        super.init()

        podsController.delegate = self

        do {
            try podsController.performFetch()
            fetched = podsController.fetchedObjects ?? []
        } catch {
            print("failed to fetch items!")
        }
    }

    // Step 6
    func getPods() async {
        if await Network.shared.getPods() != nil {
            do {
                try podsController.managedObjectContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}

// Step 4
extension PodsController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedObjects = controller.fetchedObjects as? [Pod]
        else { return }

        fetched = fetchedObjects
    }
}
```

### SpacePodApp

```swift
...
@ObservedObject var podsController = PodsController(managedObjectContext: PersistenceController.shared.container.viewContext)
...
ContentView().environmentObject(podsController)
```

### PodListView

```swift
...
@EnvironmentObject var pods: PodsController
...
if pods.fetched.isEmpty { await pods.getPods() }
```

delete getPods and change all `pods` references to `pods.fetched`

## Resources

[Donny Wals](https://www.donnywals.com/fetching-objects-from-core-data-in-a-swiftui-project/)
