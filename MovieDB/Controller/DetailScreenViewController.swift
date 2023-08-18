import UIKit

final class DetailScreenViewController: UIViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var addToMyListButton: UIButton!
    @IBOutlet private weak var playTrailerButton: UIButton!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var previewTableView: UITableView!
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
        moviePosterImage.roundedCorners()
        playTrailerButton.roundedCorners()
    }
    
    private func initData() {
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
