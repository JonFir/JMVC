import Foundation
import Alamofire
@testable import ThemoviedbOne

final class RequestBuilderMock: RequestBuilderImpl {
    
    private(set) var path: String?
    private(set) var method: HTTPMethod?
    private(set) var urlParamters: Parameters?
    private(set) var jsonParamters: Parameters?
    
    convenience init() {
        self.init(configuration: ConfigurationMock())
    }
    
    
    override func build(
        path: String,
        method: HTTPMethod,
        urlParamters: Parameters,
        jsonParamters: Parameters
    ) -> URLRequest? {
        
        self.path = path
        self.method = method
        self.jsonParamters = jsonParamters
        
        let request = super.build(
            path: path,
            method: method,
            urlParamters: urlParamters,
            jsonParamters: jsonParamters
        )
        
        let components = URLComponents(url: request!.url!, resolvingAgainstBaseURL: false)
        self.urlParamters = components?.queryItems?.reduce(into: [:]) { result, element in
            result[element.name] = element.value
        }
        return request
    }
    
}
