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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMovies()
    }
    
    private func initMovies() {
        movies.append(popularMovies)
        movies.append(trendingMovies)
        movies.append(topRatedMovies)
        movies.append(discoverMovies)
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
        guard let cell = movieTableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCell.getIdentifier() , for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }
        cell.delegate = self
        cell.setTag(tag: indexPath.section)
        cell.bindData(movies: movies[indexPath.section])
        return cell
    }
}

extension HomeViewController: MovieTableViewCellDelegate {
    func didSelectMovie(_ movie: Movie) {
            let storyBoard = UIStoryboard(name: "DetailScreen", bundle: nil)
            guard let detailScreen = storyBoard.instantiateViewController(withIdentifier: "DetailScreenViewController") as? DetailScreenViewController else { return }
            detailScreen.bindData(movie: movie)
            self.navigationController?.pushViewController(detailScreen, animated: true)
        }
}
