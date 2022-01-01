# SpacePod 30 GET by Date

Let's update our networking code to GET Pods by date, and then display them from newest to oldest.

[YouTube](https://youtu.be/0TeCKUaDUys)

## Date+Extensions

```swift
/// Returns a date string as "yyyy-MM-dd" (e.g. 2021-12-30)
var yyyy_MM_dd: String {
    return DateFormatter.yyyyMMdd.string(from: self)
}
```

## Network

```swift
let count = "&count=" + "20"
    let thumbs = "&thumbs=" + "true"
    let start = "&start_date=" + "2021-12-01"
    let end = "&end_date=" + Date().yyyy_MM_dd
...
    let url = URL(string: "\(baseUrl)\(apiKey)\(start)\(end)\(thumbs)")!
```

## PodListView

1. Temporarily Infnite Scrolling
2. `pods = pods.uniqued().reversed()`
