# SpacePod 36 Smarter Date Fetching

So far we've just been showing pods from today to December 1, 2021. Let's update our app to...

1. GET newer pods (than what's in the DB)
2. GET older pods when the user requests (taps for more)
3. What can we do about dates that don't have a pod? (gaps)

[YouTube](https://youtu.be/7rnFMaOSpTY)

## Steps

1. Date n days ago
2. GET pods `from` Date `to` Date
3. Extract saving to `save()`
4. add `delete(_ pod: Pod)`
5. where to get the from date?
6. Animation

### Step 1 Date+Extensions

```swift
extension Date {
    /// Returns the date n days ago
    func previous(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(day: -days), to: self) ?? self
    }
}
```

### Step 2 Network

Next we'll modify our getPods function to take `from` and `to` Date parameters.

```swift
...
func getPods(_ from: Date, _ to: Date) async -> [Pod]? {
    let start = "&start_date=" + from.yyyy_MM_dd
    let end = "&end_date=" + to.yyyy_MM_dd
    guard let url = URL(string: "\(url.api)\(apiKey)\(start)\(end)\(thumbs)") else { return nil }
...
```

### Step 3...

#### 3 Save

```swift
private func save() {
    do {
        try viewContext.save()
    } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}
```

#### 4 Delete

In order to test getting the newest dates we either need to come back tomorrow or add a swipe to delete function that only works in debugging mode.

```swift
private func delete(_ pod: Pod) {
    viewContext.delete(pod)
    save()
}
```

```swift
.swipeActions {
    #if DEBUG
    Button {
        viewContext.delete(pod)
        save()
    } label: {
        Label("Delete", systemImage: "trash")
    }
    .tint(.red)
    #endif
}
...
Section {
    Button("GET New") { Task { await getNew() } }
    Button("GET Old") { Task { await getOld() } }
}
```
#### getNew

First let's get any pods that are newer than whats in our CoreData store. If the newest pod is the same date as today don't do anything.

```swift
/// GET pods from newest to today
private func getNew() async {
    guard let from = pods.first?.date else { return }
    let to = Date()
    let compare = Calendar.current.compare(from, to: to, toGranularity: .day)
    if compare == .orderedAscending {
        if await Network().getPods(from, Date()) != nil {
            save()
        }
    }
}
```

#### getOld

Then we'll get the pods for the next 30 days from the oldest pod in our store.

```swift
/// GET pods from oldest to 30 days from oldest
private func getOld() async {
    guard let to = pods.last?.date?.previous(1) else { return }
    let from = to.previous(30)
    if await Network().getPods(from, to) != nil {
        save()
    }
}
```

#### Animation

Lastly let's add the default animation to our fetch request so make the experience a bit less jarring.

```swift
@FetchRequest(entity: Pod.entity(),
              sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)],
              predicate: nil,
              animation: .default)
var pods: FetchedResults<Pod>
```

## Potential Issues

1. Invalid dates get an error back from the API (e.g. 2021-02-29)

https://www.appsdeveloperblog.com/add-days-months-years-to-current-date-in-swift/
