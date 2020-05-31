import Foundation
import Alamofire
import Combine

enum ApiClientError: Error {
    case unauthorized
    case other
}

class ApiClient {
    
    let requestBuilder: RequestBuilder
    
    private let session: Session
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(
        requestBuilder: RequestBuilder,
        session: Session) {
        
        self.requestBuilder = requestBuilder
        self.session = session
    }
    
    func performRequest<T: Decodable>(_ request: URLRequest?) -> AnyPublisher<T, Error> {
        guard let request = request else {
            return Future { $0(.failure(ApiClientError.unauthorized)) }.eraseToAnyPublisher()
        }
        
        return session.request(request)
            .publishDecodable(type: T.self, queue: .global(), decoder: decoder)
            .tryMap { response in
                if response.response?.statusCode == 200, let value = response.value {
                    return value
                } else if response.response?.statusCode == 401 {
                    throw ApiClientError.unauthorized
                } else  {
                    throw ApiClientError.other
                }
        }
        .eraseToAnyPublisher()
        
    }
}
