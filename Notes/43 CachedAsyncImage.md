# SpacePod 43 CachedAsyncImage

SwiftUI's AsyncImage cache policy isn't adequate for our use, which means we're hitting the network too much. Let's write our own CachedAsyncImage view that will...

1. Fetch images given a url
2. Save images to the documents directory
3. Load images from the documents directory
4. Act as a drop in replacement for AsyncImage

## Goals

1. Dramatically decrease network traffic
2. Local image storage for future features

## Problems

There are a few issues with this implementation as is that we'll address in later installments.

1. Memory usage goes up with each image displayed
2.

## Steps

1. Set minimum `PodImageView` height to `300`
2. ~~Get documents directory as `URL`~~
3. ~~UIImage extension save as `.jpg`~~
4. Create minimum `CachedAsyncImage` view
5. ~~**GET** image by `URL`~~
6. ~~Load image from documents directory~~
7. Logic for CachedAsyncImage `body`
8. Preview for CachedAsyncImage

### Network

```swift
static let shared = Network()
```

### CachedAsyncImage

```swift
struct CachedAsyncImage<Content>: View where Content: View {

    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    @State private var image: UIImage?

    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let cached = FileManager.loadImage(name: url.lastPathComponent) ?? image {
            content(.success(Image(uiImage: cached)))
                .animation(transaction.animation, value: cached)
        } else {
            content(.empty).task {
                image = await Network.shared.getImage(url: url)
                image?.saveJPG(name: url.lastPathComponent)
            }
        }
    }
}
```

### 8 CachedAsyncImage_Previews

```swift
struct CachedAsyncImage_Previews: PreviewProvider {

    static let url = URL(string: "https://apod.nasa.gov/apod/image/2112/JwstLaunch_Arianespace_1080.jpg")!

    static var previews: some View {
        CachedAsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
            case .failure(let error):
                ErrorView(description: error.localizedDescription)
            @unknown default:
                fatalError()
            }
        }
    }
}
```
