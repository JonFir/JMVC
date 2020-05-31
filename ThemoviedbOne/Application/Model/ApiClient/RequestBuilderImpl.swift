import Foundation
import Alamofire

protocol RequestBuilder {
    func build(
        path: String,
        method: HTTPMethod,
        urlParamters: Parameters,
        jsonParamters: Parameters) -> URLRequest?
}

class RequestBuilderImpl: RequestBuilder {
    
    private let configuration: Configuration
    
    private var host: String { configuration.host }
    
    private var urlParamters: Parameters {
        ["api_key": configuration.apiKey]
    }
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func build(
        path: String,
        method: HTTPMethod,
        urlParamters: Parameters,
        jsonParamters: Parameters) -> URLRequest? {
        
        let urlParamters = self.urlParamters.merging(urlParamters, uniquingKeysWith: { _, value in value })
        var urlRequest = URL(string: host)
            .map { $0.appendingPathComponent(path) }
            .flatMap { try? URLEncoding().encode(URLRequest(url: $0), with: urlParamters) }
        
        if !jsonParamters.isEmpty {
            urlRequest = urlRequest.flatMap { try? JSONEncoding().encode($0, with: jsonParamters) }
        }
        
        urlRequest?.method = method
        
        return urlRequest
    }
    
}
