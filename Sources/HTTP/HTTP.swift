import Foundation

public class HTTP {
    public static var jsonEncoder: JSONEncoder = JSONEncoder()
    public static var jsonDecoder: JSONDecoder = JSONDecoder()
    
    public static func task(url: URL,
                     path: String,
                     method: HTTP.Method,
                     object: Encodable,
                     headers: [Header.Field: String] = [:],
                     queue: DispatchQueue = .main,
                     completion: ((Data?) -> ())? = nil) {
        guard let data = object.json else { return }
        task(url: url,
             path: path,
             method: method,
             body: data,
             headers: headers,
             queue: queue,
             completion: completion)
    }
    
    public static func task(url: URL,
                     path: String,
                     method: HTTP.Method,
                     body: Data? = nil,
                     headers: [Header.Field: String] = [:],
                     queue: DispatchQueue = .main,
                     completion: ((Data?) -> ())? = nil) {
        
        var request = Request(url: url.appendingPathComponent(path))
        request.method = method
        request.addValue("application/json", forHTTPHeaderField: .contentType)
        request.header.merge(headers) { (first, _) in first }
        request.body = body
        
        baseTask(request: request) { (data, response, error) in
            completion?(data)
        }
    }
    
    public static func getData(url: String, completionHandler: @escaping (Data) -> Void) {
        if let url = URL(string: url) {
            let request = Request(url: url)
            baseTask(request: request) { (data, response, error) in
                if let response = response,
                response.statusCode / 100 == 2,
                let data = data {
                    completionHandler(data)
                }
            }
        }
    }
    
    private static func baseTask(request: Request,
                             handler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request.raw, completionHandler: { (data, response, error) in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse else { return }
            handler(data, response, error)
        }).resume()
    }
}
