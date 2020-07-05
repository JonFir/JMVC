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
    private let decoder: JSONDecoder
    
    init(
        requestBuilder: RequestBuilder,
        session: Session,
        decoder: JSONDecoder
    ) {
        self.requestBuilder = requestBuilder
        self.session = session
        self.decoder = decoder
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
