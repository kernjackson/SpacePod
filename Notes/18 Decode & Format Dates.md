# SpacePod 18 Decoding & Formatting Dates

[YouTube](https://youtu.be/RSBE_d_ibR4)

## Goals

1. Decode date as a Date?
2. Format date nicely like this March 26, 2007
3. Sort and Query by date (eventually)
4. Cache data and images in CoreData (eventually)

## Steps

1. Formatters
2. Decoding Strategy

### DateFormatter+Extensions.swift

```swift
extension DateFormatter {

    /// Formats date as "yyyy-MM-dd" (e.g. 2021-12-18)
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    /// Formats date as "Month Day, Year" (e.g. December 18, 2021)
    static let longDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
```

### DateDecodingStrategy+Extensions

```swift
// add DateDecodingStrategy+ Extensions.swift
extension JSONDecoder.DateDecodingStrategy {
    /// Decodes Date in as yyyy-MM-dd (e.g. 2021-12-18)
    static var yyyyMMdd: JSONDecoder.DateDecodingStrategy {
        return JSONDecoder.DateDecodingStrategy.formatted(DateFormatter.yyyyMMdd)
    }
}
```

### Data+Extensions

```swift
var toPod: Pod? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .yyyyMMdd
        return try? decoder.decode(Pod?.self, from: self)
    }

    var toPods: [Pod]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .yyyyMMdd
        return try? decoder.decode([Pod]?.self, from: self)
    }
```

### Pod.swift

Change the date property from type String to Date?

```swift
let date: Date?
```
and then modify `default`

```swift
date: DateFormatter.yyyyMMdd.date(from: "yyyy-MM-dd"),
```

### PodDetailView.swift

```swift
Label(pod.date?.description ?? "", systemImage: "calendar")
```

### Data+Extensions

```swift
var toPods: [Pod]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .yyyyMMdd
        return try? decoder.decode([Pod]?.self, from: self)
    }
```

### Date+Extensions.swift

```swift
extension Date {
    /// Returns a date string as "Month Day, Year" (e.g. December 18, 2021)
    var long: String {
        return DateFormatter.longDate.string(from: self)
    }
}
```

### PodDetailView.swift

```swift
Label(pod.date?.long ?? "", systemImage: "calendar")
```#  <#Title#>

