import UIKit

final class SearchTableViewCell: UITableViewCell {
    @IBOutlet private weak var moviePosterImage: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    
    private var movie: Movie?
    private var imageProvider = ImageCache.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configPoster()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configPoster() {
        moviePosterImage.roundedCorners()
    }
    
    func setSearchTableViewCell(movie: Movie) {
        self.movie = movie
        self.movieTitle.text = movie.originalTitle
        imageProvider.getMovieImage(endPoint: movie.posterPath ?? "") { [weak self] image in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.moviePosterImage.image = image
                    }
            }
    }
}
