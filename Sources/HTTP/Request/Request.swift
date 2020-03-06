import Foundation

extension HTTP {
    struct Request {
        var url: URL
        
        public var header: [Header.Field: String] = [:]
        public var method: Method = .GET
        public var body: Data?
        public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
        public var timeout: TimeInterval = 60.0
        
        var raw: URLRequest {
            
            var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
            request.httpMethod = method.rawValue
            header.forEach({request.addValue($0.value, forHTTPHeaderField: $0.key.rawValue)})
            request.httpBody = body
            return request
        }
        
        public mutating func setBody(_ object: Encodable) {
//            guard let contentType = value(forHTTPHeaderField: .contentType) else {
//                print("HTTP: Can't add body to request: Content-Type is undefined")
//                return
//            }
//
//            switch contentType {
//            case "application/json":
//                body = object.json
//            default:
//                body = object.json
//            }
            body = object.json
        }
        
        public mutating func addValue(_ value: String, forHTTPHeaderField field: Header.Field) {
            header[field] = value
        }
        
        public func value(forHTTPHeaderField field: Header.Field) -> String? {
            return header[field]
        }
    }
}
