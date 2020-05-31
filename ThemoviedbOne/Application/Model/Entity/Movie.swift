import Foundation

struct Movie: Decodable {
    typealias Id = Int
    
    let id: Id
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    
    func with(imageUrl: String) -> Self {
        return Movie(
            id: id,
            title: title,
            posterPath: imageUrl + posterPath,
            overview: overview,
            releaseDate: releaseDate
        )
    }
}
