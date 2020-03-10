import Foundation

extension HTTP {
    struct Header {
        enum Field: String {
            case authorization = "Authorization"
            case accept = "Accept"
            case acceptEncoding = "Accept-Encoding"
            case contentType = "Content-Type"
            case cacheControl = "Cache-Control"
            case token = "Token"
        }
        enum Value: String {
            case json = "application/json"
            case xml = "application/xml"
            case stream = "application/octet-stream"
            case javascript = "application/javascript"
//            case gzip
//            case deflate
//            case compress
//            case br
//            case identity
        }
    }
}
