import Foundation
import Alamofire

func makeMockSession() -> Session {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLMockProtocol.self]
    return Session(configuration: configuration)
}
