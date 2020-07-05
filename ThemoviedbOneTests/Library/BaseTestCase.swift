import XCTest
import Combine

class BaseTestCase: XCTestCase {
    
    var cancelables = Set<AnyCancellable>()
    
    override func tearDownWithError() throws {
        
        cancelables.removeAll()
        
        try super.tearDownWithError()
    }
    
    func makeExpectation() -> XCTestExpectation {
        expectation(description: "")
    }
    
    func testSink<R, E>(
        _ publisher: AnyPublisher<R, E>,
        _ expect: XCTestExpectation? = nil
    ) -> (R?, E?) {
        var error: E?
        var result: R?
        let expect = expect ?? makeExpectation()
        
        publisher.sink(
            receiveCompletion: { [] completion in
                switch completion {
                case .failure(let e):
                    error = e
                case .finished:
                    expect.fulfill()
                }
        },
            receiveValue: { output in
                result = output
        }).store(in: &cancelables)
        waitForExpectations(timeout: 5)
        return (result, error)
    }
    
}
