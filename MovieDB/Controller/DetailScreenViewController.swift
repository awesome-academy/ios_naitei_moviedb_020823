import UIKit
import AVKit
import youtube_ios_player_helper

final class DetailScreenViewController: UIViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var addToMyListButton: UIButton!
    @IBOutlet private weak var playTrailerButton: UIButton!
    @IBOutlet private weak var infoButton: UIButton!
    @IBOutlet private weak var clearAllButton: UIButton!
    @IBOutlet private weak var similarTableView: UITableView!
    @IBOutlet private weak var moviePosterImage: UIImageView!
    @IBOutlet private weak var playerView: YTPlayerView!
    
    private var movie: Movie?
    private var senderAddress: SendingAddress?
    private var imageProvider = ImageCache.shared
    private var serviceProvider = APICaller.shared
    private var similarMovies = [Movie]()
    private var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        initData()
    }
    
    private func configUI() {
        moviePosterImage.roundedCorners()
        playTrailerButton.roundedCorners()
    }
    
    private func initData() {
        imageProvider.getImage(endPoint: movie?.posterPath ?? "") { [weak self] image in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.moviePosterImage.image = image
                    }
            }
        
        serviceProvider.getSimilarMovies(movieID: movie?.id ?? Constants.zero) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.similarMovies = movies
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.similarTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching search movies: \(error.localizedDescription)")
            }
        }
    }
    
    func bindData(movie: Movie, sender: SendingAddress) {
        self.movie = movie
        self.senderAddress = sender
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
    
    @IBAction private func clearAllButtonTapped(_ sender: UIButton) {
        guard let navigationController = self.navigationController else { return }

            var targetViewController: UIViewController?

            switch senderAddress {
            case .homeScreen:
                targetViewController = navigationController.viewControllers.first { $0 is HomeViewController }
            case .searchScreen:
                targetViewController = navigationController.viewControllers.first { $0 is SearchViewController }
            case .none:
                return
            }

            if let targetViewController = targetViewController {
                navigationController.popToViewController(targetViewController, animated: true)
            }
    }
    
    @IBAction private func infoButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Info", bundle: nil)
        guard let infoScreen = storyBoard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else { return }
        infoScreen.bindData(movie: movie ?? Movie())
        infoScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(infoScreen, animated: true)
        }
}

extension DetailScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.defaultNumOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if similarMovies.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCell.getIdentifier(), for: indexPath) as? MovieTableViewCell else {
                return MovieTableViewCell()
            }
            return cell
        } else {
            guard let cell = similarTableView.dequeueReusableCell(withIdentifier: Identifiers.tableViewCell.getIdentifier(), for: indexPath) as? MovieTableViewCell else {
                return MovieTableViewCell()
            }
            cell.delegate = self
            cell.setTableViewCell(movies: similarMovies)
            return cell
        }
    }
}

extension DetailScreenViewController: MovieTableViewCellDelegate {
    func didSelectMovie(_ movie: Movie) {
        let storyBoard = UIStoryboard(name: "DetailScreen", bundle: nil)
        guard let detailScreen = storyBoard.instantiateViewController(withIdentifier: "DetailScreenViewController") as? DetailScreenViewController else { return }
        detailScreen.bindData(movie: movie, sender: senderAddress ?? SendingAddress.homeScreen)
        detailScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }
}

extension DetailScreenViewController: YTPlayerViewDelegate {
    @IBAction private func playTrailerButtonTapped() {
        moviePosterImage.isHidden = true
        playerView?.delegate = self
        playerView.load(withVideoId: "5ELi_mdU2q8", playerVars: ["playsinline" : 1])
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
