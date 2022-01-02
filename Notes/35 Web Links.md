# SpacePod 35 SwiftUI Web Links

The api doesn't fully support all the features of the site. Let's provide a Safari link in the details view of each pod.

### DateFormatter+Extensions.swift

1. Delete `formatter.timeZone = TimeZone(secondsFromGMT: 0)` (bug fix)
2. Add `yyMMdd` formatter to `DateFormatter+Extensions`
3. Add `yyMMdd` to `Date+Extensions`
4. Add `webUrl` to `Date+Extensions`
5. Create `WebLinkView`
6. Add `WebLinkView` to `PodDetailView`

### 1, 2 DateFormatter+Extensions

```swift
/// Formats date as "yyMMdd" (e.g. 210102)
static let yyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyMMdd"
    formatter.calendar = Calendar(identifier: .iso8601)
    return formatter
}()
```

### 3, 4 Date+Extensions

```swift
/// Returns a date string as "yyMMdd" (e.g. 210102)
var yyMMdd: String {
    return DateFormatter.yyMMdd.string(from: self)
}

/// Returns the web page url for date (e.g. https://apod.nasa.gov/apod/ap220102.html)
var webUrl: URL? {
    return URL(string: "https://apod.nasa.gov/apod/ap" + self.yyMMdd + ".html")
}
```

### 5 WebLink.swift

```swift
struct WebLink: View {
    var date: Date?

    var body: some View {
        if let page = date?.webUrl {
            Link(destination: page) {
                Label("Open in Safari", systemImage: "safari.fill")
                    .symbolRenderingMode(.hierarchical)
            }
        }
    }
}
```

### 6 PodDetailView.swift

```swift
WebLink(date: pod.date)
```
