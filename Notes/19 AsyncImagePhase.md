# SpacePod 19: AsyncImagePhase, Resizing, and Scaling

## Problems

1. Images don't cover the entire width of the cell on larger screens.
2. No error is displayed if the image cannot be loaded.

### PodImageView

```swift
import SwiftUI

struct PodImageView: View {
    var url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
            case .failure:
                Label {
                    Text("Error fetching image")
                } icon: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                }
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct PodImageView_Previews: PreviewProvider {
    static var imageUrl = File.data(from: "get-pod", withExtension: .json)?.toPod?.url
    static var previews: some View {
        List {
            PodImageView(url: imageUrl!)
        }
    }
}
```

### PodDetailView

```swift
if let url = pod.url { PodImageView(url: url) }
```

### ImageRowView.swift

```swift
struct ImageRowView: View {
    var image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
    }
}
```

### ErrorRowView.swift

```swift
struct ErrorRowView: View {
    var body: some View {
        Label {
            Text("Error fetching image")
        } icon: {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
        }
    }
}
```

### Finally

Let's use our new views to clean up our switch statement.

```swift
struct PodImageView: View {
    var url: URL
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:                ProgressView()
            case .success(let image):   ImageRowView(image: image)
            case .failure(_):           ErrorRowView()
            @unknown default:           EmptyView()
            }
        }
    }
}
```
