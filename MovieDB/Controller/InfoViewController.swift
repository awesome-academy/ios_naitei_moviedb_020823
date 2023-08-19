import UIKit

class InfoViewController: UIViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieReleaseDate: UILabel!
    @IBOutlet private weak var averageVotes: UILabel!
    @IBOutlet private weak var movieLanguage: UILabel!
    @IBOutlet private weak var overviewContent: UILabel!
    @IBOutlet private weak var moviePosterImage: UIImageView!
    @IBOutlet private weak var actorTableView: UITableView!
    
    private var movie: Movie?
    private var imageProvider = ImageCache.shared
    private var serviceProvider = APICaller.shared
    private var actors = [Actor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        initData()
    }
    
    private func configUI() {
        overviewContent.lineBreakMode = .byWordWrapping
        overviewContent.numberOfLines = Constants.zero
        moviePosterImage.roundedCorners()
        actorTableView.isScrollEnabled = false
    }
    
    private func initData() {
        movieName.text = movie?.originalTitle ?? ""
        movieReleaseDate.text = movie?.releaseDate ?? ""
        movieReleaseDate.formatDate(from: Constants.responseDateFormat, to: Constants.customDateFormat)
        overviewContent.text = movie?.overview ?? ""
        averageVotes.text = String(format: "%.1f", movie?.voteAverage ?? Constants.zero)
        movieLanguage.text = Constants.defaultOriginalLanguageText + Languages.movieLanguage.getLanguage(language: movie?.originalLanguage ?? "")
        imageProvider.getImage(endPoint: movie?.posterPath ?? "") { [weak self] image in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.moviePosterImage.image = image
                    }
            }
        getActors(movieID: movie?.id ?? Constants.zero)
    }
    
    private func getActors(movieID: Int) {
        serviceProvider.getMovieActors(movieID: movieID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let actors):
                self.actors = actors
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.actorTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching search movies: \(error.localizedDescription)")
            }
        }
    }
    
    func bindData(movie: Movie) {
        self.movie = movie
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.defaultNumOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if actors.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCell.getIdentifier(), for: indexPath) as? MovieTableViewCell else {
                return MovieTableViewCell()
            }
            return cell
        } else {
            guard let cell = actorTableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCell.getIdentifier(), for: indexPath) as? MovieTableViewCell else {
                return MovieTableViewCell()
            }
            cell.setTableViewCell(actors: actors)
            return cell
        }
    }
}
