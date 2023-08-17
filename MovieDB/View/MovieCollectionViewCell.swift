import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var posterImageView: UIImageView!
    
    private var imageProvider = ImageCache.shared
    
    func setCollectionViewCell(movie: Movie) {
        imageProvider.getMovieImage(endPoint: movie.posterPath ?? "") { [weak self] image in
                guard let self = self, let image = image else { return }
                DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.posterImageView.image = image
                        self.posterImageView.roundedCorners()
                    }
            }
    }
}
