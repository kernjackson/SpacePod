# SpacePod 31 Required Init

We're still making some behind the scenes changes so that we can cache api responses using CoreData. Today we'll change Pod from a `struct` to a `class`.

[YouTube](https://youtu.be/FqV8eGpnmSw)

1. Change Pod form a `struct` to a `class`
2. Remove `Hashable` conformance
3. Add `Identifiable` conformance
4. Add `id` property
5. Add `id` case
6. Init `id = UUID()`
7. Identify by `\.id` instead of `\.self`
8. remove `.uniqued` from List
9. Add required init

```swift
let id: UUID
...
case id
...
id = UUID()
```

```swift
ForEach(pods, id: \.id) { pod in
```

```swift
required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
    date = try container.decodeIfPresent(Date.self, forKey: .date)
    explanation = try container.decode(String.self, forKey: .explanation)
    hdurl = try container.decodeIfPresent(URL.self, forKey: .hdurl)
    url = try container.decodeIfPresent(URL.self, forKey: .url)
    thumbnailUrl = try container.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
    title = try container.decode(String.self, forKey: .title)
    serviceVersion = try container.decode(String.self, forKey: .serviceVersion)
    mediaType = try container.decode(String.self, forKey: .mediaType)
}
```
