import XCTest
@testable import ThemoviedbOne

final class MoviesScreenVCTests: BaseTestCase {
    
    var moviesPagerProviderMock: MoviesPagerProviderMock!
    var moviesScreenVC: MoviesScreenVC<MoviesScreenViewMock>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        moviesPagerProviderMock = MoviesPagerProviderMock()
        moviesScreenVC = MoviesScreenVC<MoviesScreenViewMock>(moviesPagerProvider: moviesPagerProviderMock)
    }
    
    func testFavoritePressed_ShouldShowAlert() {
        
        // given
        
        let expect = makeExpectation()
        var alertData: UIAlertControllerCommonInputData?
        moviesScreenVC.onShowFavoriteAlert = {
            alertData = $0
            expect.fulfill()
        }
        moviesScreenVC.rootView.onUpdate = { $0.movies.first?.onFavoriteToogle() }
        let movies = [ Movie(id: 1, title: "", posterPath: "", overview: "", releaseDate: "") ]
        let state = MoviesPagerProviderState(movies: movies, nextPage: 1, isLoadProgress: false, error: nil)
        
        // when
        
        moviesPagerProviderMock.state.send(state)
        waitForExpectations(timeout: 1)
        
        // then
        
        XCTAssertNotNil(alertData)
        XCTAssertEqual(alertData?.title, "Упс!")
        
    }
    
}








































//final class MoviesScreenVCTests: BaseTestCase {
//    var moviesPagerProviderMock: MoviesPagerProviderMock!
//    var vc: MoviesScreenVC<MoviesScreenViewMock>!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//
//        moviesPagerProviderMock = MoviesPagerProviderMock()
//        vc = MoviesScreenVC<MoviesScreenViewMock>(moviesPagerProvider: moviesPagerProviderMock)
//    }
//
//    func test_FavoritePressed_shouldShowAlert() {
//
//        // given
//
//        let expect = makeExpectation()
//        var inputData: UIAlertControllerCommonInputData?
//        vc.onShowFavoriteAlert = { data in
//            inputData = data
//            expect.fulfill()
//        }
//        let movies = [Movie(id: 1, title: "some", posterPath: "111", overview: "sahjdk", releaseDate: "asdjkas")]
//        let state = MoviesPagerProviderState(
//            movies: movies,
//            nextPage: 1,
//            isLoadProgress: false,
//            error: nil
//        )
//        vc.rootView.onUdapte = { inputData in
//            inputData.movies.first?.onFavoriteToogle()
//        }
//
//        // when
//
//        moviesPagerProviderMock.state.send(state)
//        waitForExpectations(timeout: 1)
//
//        // then
//
//        XCTAssertNotNil(inputData)
//
//    }
//
//
//}
