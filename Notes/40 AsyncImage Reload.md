# SpacePod 40 SwiftUI AsyncImage Auto-Reload on Cancel

Sometimes our image doesn't load. I'm thinking it's because...

1. Height is unknown until `.success`
2. Image above or below succeeds before image in question
3. Request is `cancelled`

## Goals

1. Determine why it's failing
2. If `cancelled` fetch the image again
3. Otherwise display the localized error description

[YouTube](https://youtu.be/RcSi94-DNwk)

## Steps

1. Display the error description
3. Reload image if it was cancelled

## 1 Display Error Description

### ErrorView

```swift
struct ErrorView: View {
    var description: String
...
            Text(description)
...
```

## 2 Reload on Cancelled

### PodImageView

```swift
case .failure(let error): ErrorView(description: error.localizedDescription)
```

We could have a button shows the error, but let's just automatically fetch the image again instead.

```swift
case .failure(let error):
if error.localizedDescription == "cancelled" {
    PodImageView(url: url)
} else {
    ErrorView(description: error.localizedDescription)
}
```
