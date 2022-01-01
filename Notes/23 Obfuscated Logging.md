# SpacePod 23 Obfuscated Logging

Whenever we run our app it debug mode it prints every network request and response. The request and response contain the apiKey. It's only a matter of time until I accidentally leak it during a screencast. Let's fix that right now by replacing all occurrences of our apiKey with something else.

[YouTube](https://youtu.be/BMhwijis-ps)

## Problem

1. Our apiKey get printed to the console whenever we make a request.

## Goals

1. Obfuscate the key before we print it so that I don't accidentally show it on screen. 

## Steps

1. Move our print statement inside a private function.
2. Ensure we only print in production.
3. Replace our api key with a slug.
4. Clean up our existing print statements.

### 1, 2, 3

```swift
    private func log(_ string: String) {
#if DEBUG
        print(string.replacingOccurrences(of: apiKey, with: "?api_key=" + "YOUR_OBFUSCATED_API_KEY"))
#endif
    }
```

### 4

```swift
log("🌎 request: " + request.debugDescription)
```

```swift
log("🌎 response: " + response.debugDescription)
```

```swift
log("🌎 error: " + error.localizedDescription)
```

## Network.swift Complete

```swift
import Foundation

class Network {

    let baseUrl = "https://api.nasa.gov/planetary/apod"
    let apiKey = "?api_key=" + (File.data(from: "Secrets", withExtension: .json)?.toSecret?.apiKey.description ?? "DEMO_KEY")
    let count = "&count=20"
    let thumbs = "&thumbs=true"

    func getPods() async -> [Pod]? {
        let url = URL(string: "\(baseUrl)\(apiKey)\(count)\(thumbs)")!
        do {
            let request = URLRequest(url: url)
            log("🌎 request: " + request.debugDescription)
            let (data, response) = try await URLSession.shared.data(for: request)
            log("🌎 response: " + response.debugDescription)
            return data.toPods
        }
        catch {
            log("🌎 error: " + error.localizedDescription)
            return nil
        }
    }

    private func log(_ string: String) {
#if DEBUG
        print(string.replacingOccurrences(of: apiKey, with: "?api_key=" + "YOUR_OBFUSCATED_API_KEY"))
#endif
    }
}
```
