import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var moviesButton: UIButton!
    @IBOutlet private weak var myListButton: UIButton!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var movieTableView: UITableView!
    
    private var popularMovies = [Movie]()
    private var trendingMovies = [Movie]()
    private var topRatedMovies = [Movie]()
    private var discoverMovies = [Movie]()
    private var movies = [[Movie]]()
    private var sections = HomeSections.allCases
    private var serviceProvider = APICaller.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMovies()
    }
    
    private func initMovies() {
            var completedRequests = 0
        
            for type in sections {
                getMovies(type: type) { [weak self] in
                    completedRequests += 1
                    if completedRequests == self?.sections.count {
                        self?.finalizeMoviesInitialization()
                    }
                }
            }
    }
    
    func getMovies(type: HomeSections, completion: @escaping () -> Void) {
        let movieFetchHandler: (Result<[Movie], Error>) -> Void = { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                switch type {
                case .popular:
                    self.popularMovies = movies
                case .trending:
                    self.trendingMovies = movies
                case .topRated:
                    self.topRatedMovies = movies
                case .discover:
                    self.discoverMovies = movies
                }
            case .failure(let error):
                switch type {
                case .popular:
                    print("Error fetching popular movies: \(error.localizedDescription)")
                case .trending:
                    print("Error fetching trending movies: \(error.localizedDescription)")
                case .topRated:
                    print("Error fetching top rated movies: \(error.localizedDescription)")
                case .discover:
                    print("Error fetching discover movies: \(error.localizedDescription)")
                }
            }
            
            completion()
        }
        
        switch type {
        case .popular:
            serviceProvider.getPopularMovies(completion: movieFetchHandler)
        case .trending:
            serviceProvider.getTrendingMovies(completion: movieFetchHandler)
        case .topRated:
            serviceProvider.getTopRatedMovies(completion: movieFetchHandler)
        case .discover:
            serviceProvider.getDiscoverMovies(completion: movieFetchHandler)
        }
    }
    
    private func finalizeMoviesInitialization() {
        movies.append(popularMovies)
        movies.append(trendingMovies)
        movies.append(topRatedMovies)
        movies.append(discoverMovies)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movieTableView.reloadData()
        }
    }
    
    @IBAction private func myListButtonTapped() {
        let storyBoard = UIStoryboard(name: "MyListScreen", bundle: nil)
        guard let myListScreen = storyBoard.instantiateViewController(withIdentifier: "MyListViewController") as? MyListViewController else { return }
        myListScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myListScreen, animated: true)
        }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.defaultNumOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].getTitle()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if movies.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCell.getIdentifier(), for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }
                return cell
            } else {
                guard let cell = movieTableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCell.getIdentifier(), for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }
                cell.delegate = self
                cell.setTag(tag: indexPath.section)
                cell.setTableViewCell(movies: movies[indexPath.section])
                return cell
            }
    }
}

extension HomeViewController: MovieTableViewCellDelegate {
    func didSelectMovie(_ movie: Movie) {
        let storyBoard = UIStoryboard(name: "DetailScreen", bundle: nil)
        guard let detailScreen = storyBoard.instantiateViewController(withIdentifier: "DetailScreenViewController") as? DetailScreenViewController else { return }
        detailScreen.bindData(movie: movie, sender: SendingAddress.homeScreen)
        detailScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }
}
