# SpacePod 29 CodingKeys

We're still making some behind the scenes changes so that we can cache api responses using CoreData. Today we'll restore our CodingKeys from our git repo in preparation for making our model conform to `NSManagedObject`.

1. Open `Pod.swift`
2. Click `Enable Code Review`
3. Copy & Paste CodingKeys from the right pane to the left
4. Add `case thumbnailUrl`

```swift
private enum CodingKeys: String, CodingKey {
    case copyright
    case date
    case explanation
    case hdurl
    case mediaType
    case serviceVersion
    case title
    case url
    case thumbnailUrl
    }
```
