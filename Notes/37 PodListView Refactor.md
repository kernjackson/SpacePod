# SpacePod 37 PodList Refactor

The changes depicted in 36 result in a failure to load on first launch. The following changes to PodListView fix the issue, and begin the work of decluttering our `PodListView`.

## Goals

1. Fix first launch bug introduced last time
2. Move CoreData related functions to `Persistence`

## Fix Bug

### PodListView

```swift
.task {
    if pods.isEmpty { await getOld() }
}
```

```swift
private func getOld() async {
    let to = pods.last?.date?.previous(1) ?? Date()
```

## Clean Up

1. Cut and paste `delete` and `save` into `Persistence`.
2. prepend `viewContext` with `container.`

```swift
func delete(_ pod: Pod) {
    container.viewContext.delete(pod)
    save()
}

func save() {
    do {
        try container.viewContext.save()
    } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}
```

3. `save()` to `PersistenceController.shared.save()`
4. `delete()` to `PersistenceController.shared.delete(pod)`
