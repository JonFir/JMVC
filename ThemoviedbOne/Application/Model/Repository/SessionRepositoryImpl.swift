import Foundation

protocol SessionRepository: AnyObject {
    var sessionID: String? { get set }
}

class SessionRepositoryImpl: SessionRepository {
    var sessionID: String?
}
