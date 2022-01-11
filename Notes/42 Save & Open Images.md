# SpacePod 42 Save & Open Images

SwiftUI's AsyncImage cache policy isn't adequate for our use, which means we're hitting the network too much. Let's write our own CachedAsyncImage view that will...

1. Fetch images given a url
2. Save images to the documents directory
3. Load images from the documents directory
4. Act as a drop in replacement for AsyncImage

For now we'll just implement Step 2 and 3.

## Goals

1. Dramatically decrease network traffic
2. Local image storage for future features

## Steps

### 2a FileManager+Extension

```swift
extension FileManager {
    static var getDocumentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
```

### 2b UIImage+Extension

```swift
extension UIImage {
    func saveJPG(named: String) {
        if let data = self.jpegData(compressionQuality: 1.0) {
            let filename = FileManager.getDocumentsDirectory.appendingPathComponent("\(named)")
            log("🗃 \(filename)")
            try? data.write(to: filename)
        }
    }
}
```

### 3 Load Image

```swift
extension FileManager {

    private func loadImage(name: String) -> UIImage? {
        let filename = FileManager.getDocumentsDirectory.appendingPathComponent("\(name)")
        let image = UIImage(contentsOfFile: filename.path)
        log("🗃 \(filename)")
        return image
    }
}
```
