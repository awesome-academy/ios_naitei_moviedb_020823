import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var posterImageView: UIImageView!
    
    private var imageProvider = ImageCache.shared
    
    func setCollectionViewCell(item: Any) {
        var imagePath: String?

        if let movie = item as? Movie {
            imagePath = movie.posterPath
        } else if let actor = item as? Actor {
            imagePath = actor.profilePath
        }

        guard let imagePath = imagePath else { return }

        imageProvider.getImage(endPoint: imagePath) { [weak self] image in
            guard let self = self, let image = image else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.posterImageView.image = image
                self.posterImageView.roundedCorners()
            }
        }
    }
}
