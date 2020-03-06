import Foundation

extension Encodable {
    var json: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
//    var stringDictionary: [String: String]? {
//        return dictionary?.valuesToString()
//    }
//    
//    var dictionary: [String: Any]? {
//        do {
//            let data = try JSONEncoder().encode(self)
//            
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            
//            return jsonObject as? [String: Any]
//            
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
//    }
}

extension Decodable {
    static func decode(json: Data) -> Self? {
        do {
            return try JSONDecoder().decode(Self.self, from: json)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
