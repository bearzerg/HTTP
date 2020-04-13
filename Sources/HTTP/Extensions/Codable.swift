import Foundation

extension Encodable {
    var json: Data? {
        do {
            return try HTTP.jsonEncoder.encode(self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension Decodable {
    static func decode(json: Data) -> Self? {
        do {
            return try HTTP.jsonDecoder.decode(Self.self, from: json)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
