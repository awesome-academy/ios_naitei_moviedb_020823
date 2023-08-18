import UIKit

class InfoViewController: UIViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieReleaseDate: UILabel!
    @IBOutlet private weak var averageVotes: UILabel!
    @IBOutlet private weak var movieLanguage: UILabel!
    @IBOutlet private weak var overviewContent: UILabel!
    @IBOutlet private weak var moviePosterImage: UIImageView!
    
    private var movie: Movie?
    private var sender: SendingAddress?
    private var imageProvider = ImageCache.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        initData()
    }
    
    private func configUI() {
        switch sender {
        case .homeScreen:
            backButton.isEnabled = true
            backButton.isHidden = false
        case .searchScreen:
            backButton.isEnabled = false
            backButton.isHidden = true
        case .none:
            backButton.isEnabled = false
            backButton.isHidden = true
        }
        overviewContent.lineBreakMode = .byWordWrapping
        overviewContent.numberOfLines = Constants.zero
        moviePosterImage.roundedCorners()
    }
    
    private func initData() {
        movieName.text = movie?.originalTitle ?? ""
        movieReleaseDate.text = movie?.releaseDate ?? ""
        movieReleaseDate.formatDate(from: Constants.responseDateFormat, to: Constants.customDateFormat)
        overviewContent.text = movie?.overview ?? ""
        averageVotes.text = String(format: "%.1f", movie?.voteAverage ?? Constants.zero)
        movieLanguage.text = Constants.defaultOriginalLanguageText + Languages.movieLanguage.getLanguage(language: movie?.originalLanguage ?? "")
        imageProvider.getMovieImage(endPoint: movie?.posterPath ?? "") { [weak self] image in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.moviePosterImage.image = image
                    }
            }
    }
    
    func bindData(movie: Movie, sender: SendingAddress) {
        self.movie = movie
        self.sender = sender
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
}
