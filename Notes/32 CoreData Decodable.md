# SpacePod 32 CoreData Decodable NSManagedObject

Previously we added a CoreData model named `Nasa`. Let's rename it to `Pod` to mirror our existing object, and then work through the resulting build errors so that our app is using the new object.

## Goals

1. Mirror CoreData Model and Pod Model
2. Update Pod to work with CoreData
3. Update our views to ensure everything still works as before

## Steps

1. Rename `Nasa` to `Pod`
2. Change Codegen to `Category/Extension`, and
3. Set module to current and save
4. `import CoreData`
5. `NSManagedObject`
6. Delete properties in Pod
7.  Change `Codble` to `Decodable`
8.  Remove id
9.  add `DecoderConfigurationError`
10. add `CodingUserInfoKey`
11. add `convenience`
12. add `context`
13. add `self.init`
14. add `decoder.userInfo[CodingUserInfoKey.managedObjectContext] = PersistenceController.shared.container.viewContext`
15. add `if let` to optionals in views

## Steps

### 1, 2, 3

```xml
<entity name="Pod" representedClassName=".Pod" syncable="YES" codeGenerationType="category">
```

### 4 to 13, Pod.swift Complete

```swift
import Foundation
import CoreData

class Pod: NSManagedObject, Decodable {

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

    enum DecoderConfigurationError: Error {
        case missingManagedObjectContext
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectText] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        date = try container.decodeIfPresent(Date.self, forKey: .date)
        explanation = try container.decode(String.self, forKey: .explanation)
        hdurl = try container.decodeIfPresent(URL.self, forKey: .hdurl)
        mediaType = try container.decode(String.self, forKey: .mediaType)
        serviceVersion = try container.decode(String.self, forKey: .serviceVersion)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        thumbnailUrl = try container.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
    }
}

extension CodingUserInfoKey {
    static let managedObjectText = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
```

## 14 Data+Extensions.swift

```swift
decoder.userInfo[CodingUserInfoKey.managedObjectContext] = PersistenceController.shared.container.viewContext
```

## 15 Optionals

Handle optionals in our views with `if let...` (for now)
