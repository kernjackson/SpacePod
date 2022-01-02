import Foundation

extension Date {
    /// Returns a date string as "Month Day, Year" (e.g. December 18, 2021)
    var long: String {
        return DateFormatter.longDate.string(from: self)
    }

    /// Returns a date string as "yyyy-MM-dd" (e.g. 2021-12-30)
    var yyyy_MM_dd: String {
        return DateFormatter.yyyyMMdd.string(from: self)
    }

    /// Returns a date string as "yyMMdd" (e.g. 211230)
    var yyMMdd: String {
        return DateFormatter.yyMMdd.string(from: self)
    }

    /// Returns the web page for date (e.g. https://apod.nasa.gov/apod/ap220102)
    var webUrl: URL? {
        return URL(string: "https://apod.nasa.gov/apod/ap" + self.yyMMdd + ".html")
    }
}
