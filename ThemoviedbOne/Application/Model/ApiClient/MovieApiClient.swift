import Combine
import Foundation
import Alamofire

protocol MovieApiClient {
    
    func movieList(page: Int) -> AnyPublisher<ApiClient.MovieListResponse, Error>
    
    func movie(id: Int) -> AnyPublisher<Movie, Error>
    
    func searchMovie(query: String, page: Int) -> AnyPublisher<ApiClient.SearchMovieResponse, Error>
}

extension ApiClient: MovieApiClient {
    
    struct MovieListResponse: Decodable {
        let page: Int
        let totalPages: Int
        let results: [Movie]
    }
    
    func movieList(page: Int) -> AnyPublisher<ApiClient.MovieListResponse, Error> {
        
        let request = requestBuilder.build(
            path: "/discover/movie",
            method: .get,
            urlParamters: [
                "page": "\(page)",
                "sort_by": "popularity.desc"
            ],
            jsonParamters: [:]
        )
        
        return performRequest(request)
    }
    
    func movie(id: Int) -> AnyPublisher<Movie, Error> {
        let request = requestBuilder.build(
            path: "/movie/\(id)",
            method: .get,
            urlParamters: [:],
            jsonParamters: [:]
        )
        
        return performRequest(request)
    }
    
    struct SearchMovieResponse: Decodable {
        let page: Int
        let totalPages: Int
        let results: [Movie]
    }
    
    func searchMovie(query: String, page: Int) -> AnyPublisher<ApiClient.SearchMovieResponse, Error> {
        let request = requestBuilder.build(
            path: "/search/movie",
            method: .get,
            urlParamters: [
                "page": "\(page)",
                "query": query
            ],
            jsonParamters: [:]
        )
        
        return performRequest(request)
    }
    
}
