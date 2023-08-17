import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!
    
    private var movies = [Movie]()
    private var previousText = ""
    private var timer: Timer?
    private var serviceProvider = APICaller.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSearchBar()
    }
    
    private func getSearchMovie(name: String) {
        serviceProvider.search(searchKey: name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.searchTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching search movies: \(error.localizedDescription)")
            }
        }
    }
    
    private func configSearchBar() {
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
                   textFieldInsideSearchBar.textColor = UIColor.white
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if movies.isEmpty { return }
        let storyBoard = UIStoryboard(name: "DetailScreen", bundle: nil)
        guard let detailScreen = storyBoard.instantiateViewController(withIdentifier: "DetailScreenViewController") as? DetailScreenViewController else { return }
        detailScreen.bindData(movie: movies[indexPath.row], sender: SendingAddress.searchScreen)
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.isEmpty { return Constants.defaultNumOfRows } else { return movies.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: Identifiers.noResultCell.getIdentifier(), bundle: nil), forCellReuseIdentifier: Identifiers.noResultCell.getIdentifier())
        if movies.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.noResultCell.getIdentifier(), for: indexPath) as? NoResultCell else { return NoResultCell() }
                return cell
        } else {
            guard let cell = searchTableView.dequeueReusableCell(withIdentifier: Identifiers.searchTableViewCell.getIdentifier(), for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
            cell.setSearchTableViewCell(movie: movies[indexPath.row])
            return cell }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText
        if query.isEmpty {
            self.getSearchMovie(name: self.previousText)
        } else {
            if query.trimmingCharacters(in: .whitespaces).count >= 3 {
                self.previousText = query
                timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { (_) in
                    self.getSearchMovie(name: query)
                })
            }
        }
    }
}
