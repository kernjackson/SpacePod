import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static var yyyyMMdd: JSONDecoder.DateDecodingStrategy {
        return JSONDecoder.DateDecodingStrategy.formatted(DateFormatter.yyyyMMdd)
    }
}
