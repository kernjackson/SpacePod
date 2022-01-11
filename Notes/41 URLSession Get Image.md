# SpacePod 41 URLSession GET Image

SwiftUI's AsyncImage cache policy isn't adequate for our use, which means we're hitting the network too much. Let's write our own CachedAsyncImage view that will...

1. Fetch images given a url
2. Save images to the documents directory
3. Load images from the documents directory
4. Act as a drop in replacement for AsyncImage

For now we'll just implement Step 1.

## Goals

1. Dramatically decrease network traffic
2. Local image storage for future features

## Steps

### Network

```swift
private func getImage(url: URL) async -> UIImage? {
    do {
        let request = URLRequest(url: url)
        log("🌎 request: " + request.debugDescription)
        let (data, response) = try await URLSession.shared.data(for: request)
        log("🌎 response: " + response.debugDescription)
        return UIImage(data: data)
    }
    catch {
        log("🌎 error: " + error.localizedDescription)
        return nil
    }
}
```

```swift
func log(_ string: String) {
#if DEBUG
    print(string)
#endif
}
```
