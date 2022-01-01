# SpacePod 33 CoreData Save & Fetch

We've done the ground work in the last few videos, and we're finally ready to save to and fetch from our CoreData store.

[YouTube](https://youtu.be/MsrhQ3VzOIQ)

## Steps

1. Add `.environment` and specify `\.managedObjectContext` keypath
2. Add `@Environment` var `viewContext` to PodListView
3. Create `@FetchRequest` and sort by date descending
4. Save context on getPods completion
5. Fix previews

### SpacePodApp.swift

```swift
...
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
...
```

### PodListView

```swift
//@State var pods: [Pod] = []
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Pod.entity(),
        sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]
    ) var pods: FetchedResults<Pod>

...

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
...
PodListView()
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
```

## Resources

[Core Data Lab](https://betamagic.nl/products/coredatalab.html)
[Donny Wals on Core Data](https://www.donnywals.com/category/core-data/)
[Sarunw on What is @Environment in SwiftUI](https://sarunw.com/posts/what-is-environment-in-swiftui/)
