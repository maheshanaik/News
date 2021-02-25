

import Foundation

class APIManager {
    
    func getData(fromURL url: URL, completion: @escaping (_ result: Result?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                completion(Result(data: data, response: Response(fromURLResponse: response), error: error))
            })
            task.resume()
        }
    }
}

extension APIManager {

    struct Response {
        var response: URLResponse?
        var httpStatusCode: Int = 0
        
        init(fromURLResponse response: URLResponse?) {
            guard let response = response else { return }
            self.response = response
            httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        }
    }
    
    enum CustomError  {
        case noData
        case inValidUrl
        case serverError
        case internetNotConnected
    }
    
    struct Result {
        var data: Data?
        var response: Response?
        var error: CustomError?
        
        init(data: Data?, response: Response?, error: Error?) {
            self.data = data
            self.response = response
            if let error = error as NSError?, error.domain == NSURLErrorDomain, error.code == NSURLErrorNotConnectedToInternet {
                self.error = .internetNotConnected
            } else if response?.httpStatusCode == 404 {
                self.error = .inValidUrl
            } else if response?.httpStatusCode == 500 {
                self.error = .serverError
            }
        }
    }
}

extension APIManager.CustomError {
    public var errorMessage: String {
        switch self {
        case .inValidUrl:
            return "Please provide valid url"
        case .internetNotConnected:
            return "Please check internet connection"
        case .noData:
            return "Unable to parse data"
        case .serverError:
            return "Server is not responding"
        }
    }
}

