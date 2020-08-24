import UIKit
import Combine

final class MoviesScreenVC<View: MoviesScreenView>: BaseViewController<View> {
    typealias OnSelectMovie = (Movie.Id) -> Void
    typealias OnShowFavorite = (UIAlertControllerCommonInputData) -> Void
    
    var onSelectMovie: OnSelectMovie?
    var onShowFavoriteAlert: OnShowFavorite?
    
    private let moviesPagerProvider: MoviesPagerProvider
    private var cancalables = Set<AnyCancellable>()
    
    init(moviesPagerProvider: MoviesPagerProvider) {
        self.moviesPagerProvider = moviesPagerProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.loadView()
        
        title = "Popular moview"
        
        moviesPagerProvider.state
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.onStateChange($0) }
            .store(in: &cancalables)
        moviesPagerProvider.nextPage()
        rootView.events.sink { [weak self] in self?.onViewEnvent($0) }.store(in: &cancalables)
    }
    
    private func onViewEnvent(_ event: MoviesScreenViewEvent) {
        switch event {
        case .scrollAtEnd:
            moviesPagerProvider.nextPage()
        }
    }
    
    private func onStateChange(_ state: MoviesPagerProviderState) {
        rootView.udapte(with: makeMoviesScreenViewInputData(from: state))
    }
    
    private func makeMoviesScreenViewInputData(from state: MoviesPagerProviderState) -> MoviesScreenViewInputData {
        let movies = state.movies.map(makeMovieViewCellInputData)
        let error = state.error.map {_ in ErrorInputData.applicationError }
        let zeroError: ErrorInputData?
        let errorMessage: ErrorInputData?
        
        if movies.isEmpty {
            zeroError = error
            errorMessage = nil
        } else {
            zeroError = nil
            errorMessage = error
        }
        
        return MoviesScreenViewInputData(
            movies: movies,
            zeroError: zeroError,
            errorMessage: errorMessage
        )
    }
    
    private func makeMovieViewCellInputData(from movie: Movie) -> MovieViewCellInputData {
        return MovieViewCellInputData(
            id: movie.id,
            posterUrl: URL(string: movie.posterPath),
            title: movie.title,
            description: movie.overview,
            isFavorite: false,
            onSelect: { [weak self] in self?.onSelectMovie?(movie.id) },
            onFavoriteToggle: { [weak self] in self?.showShowFavoriteAlert() }
        )
    }
    
    private func showShowFavoriteAlert() {
        let data = UIAlertControllerCommonInputData(
            title: "Упс!",
            message: "Добавление в избранное, пока не реализовано(",
            buttons: [
                .init(title: "Хорошо")
            ]
        )
        onShowFavoriteAlert?(data)
    }
    
}

/*
1) Что такое попап?
   а) Просто вью (семантически)
   б) Вью контроллер (технически).

2) Кто должен его показывать.
   а) Вью (семантически)
       + Это правильное место в нашей архитектуре
       + легко тестировать юнитами
       - сложно реализовывать. для реализации требуется контроллер, которого нет в UIView
   б) Вью контроллер (технически)
       + Легко реализовать
       + Правильно место в архитектуре. Если попап вьюшка, то именно контроллер должен ею управлять
       - сложно тестировать юнитами
   в) Координатор (потому что отвечает за переходы и показы контроллеров)
       + легко тестировать юнитами
       +- средняя сложность реализация
       - не правильно с архитектурной точки зрения
       - прийдется закрывать тестами координаторы
*/
