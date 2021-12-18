import Foundation

extension Date {
    /// Returns a date string as "Month Day, Year" (e.g. December 18, 2021)
    var long: String {
        return DateFormatter.longDate.string(from: self)
    }
}
