import Foundation

public class HTTP {
    
    static func task(url: URL,
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

extension HTTP {
    
    public static func getData(url: String, completionHandler: @escaping (Data) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let response = response as? HTTPURLResponse,
                    response.statusCode / 100 == 2,
                    let data = data {
                    completionHandler(data)
                }
            }.resume()
        }
    }
    
    public static func task(url: URL,
                     path: String,
                     method: String,
                     body: Data? = nil,
                     headers: [String: String] = [:],
                     queue: DispatchQueue = .main,
                     completion: ((Data?) -> ())? = nil) {
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach({request.addValue($0.value, forHTTPHeaderField: $0.key)})
        request.httpBody = body
        
        task(request: request, queue: queue, completion: completion)
    }
    
    private static func task(request: URLRequest,
                             queue: DispatchQueue = .main,
                             completion: ((Data?) -> ())? = nil) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            guard let data = data else { return }
            
            queue.async { completion?(data) }
            
        }.resume()
    }
}
