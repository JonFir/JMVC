import Combine
import Foundation
import Alamofire

protocol FavoriteApiClient {
    
    func updateFavorite(id: Int, isFavorite: Bool) -> AnyPublisher<ApiClient.UpdateFavoriteResponse, Error>
    
    func favotites(page: Int) -> AnyPublisher<ApiClient.FavotitesResponse, Error>
    
}

extension ApiClient: FavoriteApiClient {
    
    struct UpdateFavoriteResponse: Decodable {
        let statusMessage: Int
    }
    
    func updateFavorite(id: Int, isFavorite: Bool) -> AnyPublisher<ApiClient.UpdateFavoriteResponse, Error> {
        let request = requestBuilder.build(
            path: "/account/{account_id}/favorite",
            method: .post,
            urlParamters: [
                "session_id": "asdasd"
            ],
            jsonParamters: [
                "media_type": "movie",
                "media_id": id,
                "favorite": isFavorite
            ]
        )
        
        return performRequest(request)
    }
    
    struct FavotitesResponse: Decodable {
        let page: Int
        let totalPages: Int
        let results: [Movie]
    }
    
    func favotites(page: Int) -> AnyPublisher<ApiClient.FavotitesResponse, Error> {
        let request = requestBuilder.build(
            path: "/account/{account_id}/favorite/movies",
            method: .get,
            urlParamters: [
                "session_id": "asdasd",
                "page": "\(page)"
            ],
            jsonParamters: [:]
        )
        
        return performRequest(request)
    }
    
}
