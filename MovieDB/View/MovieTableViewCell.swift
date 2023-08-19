import UIKit

protocol MovieTableViewCellDelegate: AnyObject {
    func didSelectMovie(_ movie: Movie)
}

final class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    
    private var movies = [Movie]()
    private var actors = [Actor]()
    
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
    
    func setTableViewCell(movies: [Movie]) {
        self.movies = movies
        self.movieCollectionView.reloadData()
    }
    
    func setTableViewCell(actors: [Actor]) {
        self.actors = actors
        self.movieCollectionView.reloadData()
    }
}

extension MovieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movies.isEmpty { return actors.count } else { return movies.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.collectionViewCell.getIdentifier(), for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        if actors.isEmpty { cell.setCollectionViewCell(item: movies[indexPath.item]) } else { cell.setCollectionViewCell(item: actors[indexPath.item]) }
        return cell
    }
}

extension MovieTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if actors.isEmpty { delegate?.didSelectMovie(movies[indexPath.item]) } else { return }
    }
}
