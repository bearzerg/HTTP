import Foundation

extension HTTP {
    struct Header {
        enum Field: String {
            case contentType = "Content-Type"
            case accept = "Accept"
            case cacheControl = "Cache-Control"
            case authorization = "Authorization"
            case enccoding = "Accept-Encoding"
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
