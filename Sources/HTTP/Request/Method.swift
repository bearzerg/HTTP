import Foundation

public extension HTTP {
    enum Method: String {
        case GET
        case HEAD
        
        case POST
        case PUT
        case PATCH
        
        case DELETE
        
        case TRACE
        case OPTIONS
    }
}
