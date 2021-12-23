# SpacePod 24 Infinite SwiftUI List

We're only showing 20 Pods at a time. Let add infinite scrolling.

## Goals

1. Add infinite scrolling
2. Ensure pods are unique

## Steps

1. Append to pods instead of replacing it
2. Animate the change
3. getPods() when last row appears
4. Ensure pods are unique

### 1, 2 Append and Animate

```swift
private func getPods() async {
    if let response = await Network().getPods() {
        withAnimation {
            pods += response
        }
    }
}
```

### 3 getPods() when last row appears

```swift
NavigationLink(destination: PodDetailView(pod: pod)) {
    Text(pod.title)
}
.task {
    if pod == pods.last {
        await getPods()
    }
}
```

### 4 Ensure pods are unique

Adapted from [SwiftLee](https://www.avanderlee.com/swift/unique-values-removing-duplicates-array/).

```swift
// from https://www.avanderlee.com/swift/unique-values-removing-duplicates-array/
public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
```
