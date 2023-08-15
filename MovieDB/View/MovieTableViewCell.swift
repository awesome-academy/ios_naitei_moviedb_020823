import UIKit

protocol MovieTableViewCellDelegate: AnyObject {
    func didSelectMovie(_ movie: Movie)
}

final class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    
    private var movies = [Movie]()
    weak var delegate: MovieTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTag(tag: Int) {
        movieCollectionView.tag = tag
    }
    
    func bindData(movies: [Movie]) {
        self.movies = movies
    }
}

extension MovieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.collectionViewCell.getIdentifier(), for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension MovieTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMovie(movies[indexPath.item])
    }
}
