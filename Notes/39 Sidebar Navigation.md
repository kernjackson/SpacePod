# SpacePod 39 Side Bar

Let's modify the UI by adding a Sidebar and showing images in our list.

## Goals

1. Improve navigation
2. Beautify app
3. Clarify navigation

[YouTube](https://youtu.be/Rb-A00VpFRI)

## Steps

1. Use Pod.recent request
2. Add `SidebarView`
3. Replace List `Text` with our `PodDetailView`
4. Move app structure to `ContentView`
5. Change `List` to `Section` in PodDetailView
6. Switch on pods
7. Split our list view into `loadingView` and `listView`
8. Set the environment for our `Content` and `SidebarView` previews

```swift
struct SideBarView: View {
    var body: some View {
        List {
            NavigationLink {
                PodListView()
            } label: {
                Label("Recents", systemImage: "clock")
            }

        }
    }
}
```

### ContentView

```swift
struct ContentView: View {
    var body: some View {
        NavigationView {
            SidebarView()
            PodListView()
        }
    }
}
```

### PodDetailView

`List` to `Section`

### PodListView

```swift
struct PodListView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Pod.recent, animation: .default)
    var pods: FetchedResults<Pod>

    var body: some View {

        switch pods {
        case nil: loadingView
        default:  listView
        }
    }

    var loadingView: some View {
        Text("Fetching Pods...")
            .task {
                if pods.isEmpty { await getMore() }
            }
    }

    var listView: some View {
        List {
            ForEach(pods, id: \.id) { pod in
                PodDetailView(pod: pod)
            }
            Section {
                Button("GET More") { Task { await getMore() } }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            await getNew()
        }
    }
}
```

## Previews

Be sure to Set the environment value for our `ContentView` and `SideBarView`

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
```

```swift
struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        // Wrapping it with a NavigationView enables the expected behavior in Canvas
        NavigationView {
            SidebarView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
```
