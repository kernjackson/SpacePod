# SpacePod 17 - App Secrets

## Thoughts

Lot's of ways to do this, and all of them have drawbacks. We are doing it this way to keep things simple. Warning, this approach is simple, but the api key will in **plaintext** in the app bundle!!!

[YouTube](https://youtu.be/HbMgDKIK_4s)

### Other Methods

1. Environment setting
2. CI/CD
3. Shared iCloud database
4. Bypass the API altogether

## Objectives

1. Use **your** api key instead of the demo key
2. Make sure we **don't** check our api key into the repo

## Steps

1. Update Network.swift
2. Create .gitignore
3. Copy & paste from github
4. Add Secrets.json to .gitignore?
5. Add Secrets.json to project and target
6. Create Secrets.swift model
7. Load apiKey from Secrets.txt ?? DEMO_KEY

### Secret.swift

1. New Group "Models"
2. New Type Secret

```swift
import Foundation

struct Secret: Codable {
    let apiKey: String
}
```

### Decoding

```swift
var toSecret: Secret? {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try? decoder.decode(Secret.self, from: self)
}
```

### Update Network

Delete `getString()` & `getPod()`

```swift
import Foundation

class Network {

    let baseUrl = "https://api.nasa.gov/planetary/apod"
    let apiKey = "?api_key=" + (File.data(from: "Secrets", withExtension: .json)?.toSecret?.apiKey.description ?? "DEMO_KEY")

    func getPods() async -> [Pod]? {
        let url = URL(string: "\(baseUrl)\(apiKey)&count=20")!
        do {
            let request = URLRequest(url: url)
#if DEBUG
            print("🌎 request: " + request.debugDescription)
#endif
            let (data, response) = try await URLSession.shared.data(for: request)
#if DEBUG
            print("🌎 response: " + response.debugDescription)
#endif
            return data.toPods
        }
        catch {
#if DEBUG
            print("🌎 error: " + error.localizedDescription)
#endif
            return nil
        }
    }
}
```

### Create .gitignore

1. Add a new empty file at the root of the project and name it ".gitignore". Be sure to **not**include it in our target.
2. Copy and paste the contents of [Swift.gitignore](https://github.com/github/gitignore/blob/main/Swift.gitignore) into .gitignore.
3. Add Secrets.json to .gitignore

```bash
# Project
Secrets.json
```

### Add Secrets.json

1. Select the project
2. Right click to create a new file named Secrets.json
3. Be sure to include it with SpacePod target
4. Add the following json
5. Be sure to change apiKey to **your** api key from https://api.nasa.gov and save

```json
{
	"api_key" : "PASTE_YOUR_API_KEY_HERE"
}
```

