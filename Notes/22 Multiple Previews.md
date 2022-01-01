# SpacePod 22 - SwiftUI Previews - Device, DisplayName, & InterfaceOrientation

Previously we added a "Fetching Pods..." view whenever we don't have any pods to display. This works well enough on iPads, but results in a blank screen on iPhones. Let's fix the problem and add some additional previews along the way.

## Problem

Fetching pods doesn't show on iPhones in portrait mode

[YouTube](https://youtu.be/R59FkVIxtGs)

## Goals

1. Show "Fetching Pods" on iPhone and iPads in any orientation
2. Use `.previewDevice()`
3. Use `.previewDisplayName()`
4. Use `.previewInterfaceOrientation()`

## Steps

1. Create a preview with empty pods
2. Add a second `Text("Fetching Pods...")`
3. Attach task to NavigationView
4. Move list inside `if let pod = pods.first {`
5. Add previewDevice
6. Add previewDisplayName
8. Add previewInterfaceOrientation
8. Create two iPad Layouts

### View

#### NavigationView Task

```swift
NavigationView {
    
}
.task {
    if pods.isEmpty { await getPods() }
}
```

#### List

```swift
if let pod = pods.first {
    List {
        ...
```

#### "Fetching Pods..."

```swift
} else {
    Text("Fetching Pods...")
    Text("Fetching Pods...")
}
```

### Previews

```swift
PodListView(pods: [])
    .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
    .previewDisplayName("iPhone 13 mini - Fetching Pods...")
```

```swift
PodListView(pods: pods!)
    .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
    .previewDisplayName("iPhone 13 mini - Fetching Pods...")
```

```swift
PodListView(pods: [])
    .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
    .previewDisplayName("iPad mini - Fetching Pods...")
    .previewInterfaceOrientation(.landscapeRight)
PodListView(pods: pods!)
    .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
    .previewDisplayName("iPad mini")
    .previewInterfaceOrientation(.landscapeRight)
```

### PodListView.swift Complete

```swift
import SwiftUI

struct PodListView: View {
    @State var pods: [Pod] = []

    var body: some View {
        NavigationView {

            if let pod = pods.first {
                List {
                    ForEach(pods, id: \.self) { pod in
                        NavigationLink(destination: PodDetailView(pod: pod)) {
                            Text(pod.title)
                        }
                    }
                }
                .navigationTitle("SpacePod")
                .navigationBarTitleDisplayMode(.inline)

                .refreshable {
                    await getPods()
                }
                PodDetailView(pod: pod)

            } else {
                Text("Fetching Pods...")
                Text("Fetching Pods...")
            }
        }
        .task {
            if pods.isEmpty { await getPods() }
        }
    }

    private func getPods() async {
        if let response = await Network().getPods() {
            pods = response
        }
    }
}

struct PodListView_Previews: PreviewProvider {
    static var pods = File.data(from: "get-pods", withExtension: .json)?.toPods
    static var previews: some View {

        // Disable some of these if your previews are timing out.

        PodListView(pods: [])
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
            .previewDisplayName("iPhone 13 mini - Fetching Pods...")
        PodListView(pods: pods!)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
            .previewDisplayName("iPhone 13 mini")

        PodListView(pods: [])
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewDisplayName("iPad mini - Fetching Pods...")
            .previewInterfaceOrientation(.landscapeRight)
        PodListView(pods: pods!)
            .previewDevice(PreviewDevice(rawValue:  "iPad mini (6th generation)"))
            .previewDisplayName("iPhone 13 mini")
            .previewInterfaceOrientation(.landscapeRight)
    }
}
```
