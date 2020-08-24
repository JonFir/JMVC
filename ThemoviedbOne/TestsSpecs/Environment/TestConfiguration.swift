import Foundation

#if DEBUG
class TestConfiguration {

    static let shared = TestConfiguration()

    // MARK: - Types
    
    enum Key: String {
        case isTesting
        case startFlow
    }
    
    // MARK: - Public Properties
    
    var isTesting: Bool {
        environmentProvider.contains(argument: .isTesting)
    }
    
    var startFlow: StartFlow {
        environmentProvider.environment(key: .startFlow).flatMap(StartFlow.init)!
    }

    // MARK: - Private Properties
    
    private let environmentProvider = ProcessInfoEnvironmentProvider<Key>()
    
}
#endif
