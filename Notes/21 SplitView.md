# SpacePod 21 SwiftUI 'Split View'

[YouTube](https://youtu.be/90BKOqN4dNE)

## Issues

1. Large empty area when app launches
2. Navigation title layout issues

## Steps

1. Detail View (**do not** put in in an HStack)
2. Loading View
3. NavigationView tweaks

### PodListView.swift Changes

#### Loading...

```swift
Text("Fetching Pods...")
```

#### Display First Pod

```swift
if let pod = pods.first {
        PodDetailView(pod: pod)
} else {
        Text("Fetching Pods...")
}
```

#### Nav View Tweaks

```swift
List {
...
    .navigationTitle("SpacePod")
    .navigationBarTitleDisplayMode(.inline)
```

### PodListView.swift Complete

```swift
struct PodListView: View {
    @State var pods: [Pod] = []

    var body: some View {
        NavigationView {

            List {
                ForEach(pods, id: \.self) { pod in
                    NavigationLink(destination: PodDetailView(pod: pod)) {
                        Text(pod.title)
                    }
                }
            }
            .navigationTitle("SpacePod")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if pods.isEmpty { await getPods() }
            }
            .refreshable {
                await getPods()
            }

            if let pod = pods.first {
                PodDetailView(pod: pod)
            } else {
                Text("Fetching Pods...")
            }

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
        PodListView(pods: pods!)
    }
}

```
