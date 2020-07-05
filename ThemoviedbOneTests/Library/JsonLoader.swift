import Foundation

final class JsonLoader {
    private init(){}
    
    static func loadJsonAsData(name: String) -> Data {
        let path = Bundle(for: self.self).url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: path)
    }
}


