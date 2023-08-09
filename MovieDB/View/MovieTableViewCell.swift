import UIKit

final class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var movieCollectionView: UICollectionView!
    
    private var movies = [Movie]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionMovieCell", for: indexPath) as? CollectionMovieCell else { return UICollectionViewCell() }
        return cell
    }
}
