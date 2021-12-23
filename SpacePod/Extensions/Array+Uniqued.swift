import Foundation

// from https://www.avanderlee.com/swift/unique-values-removing-duplicates-array/
public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
