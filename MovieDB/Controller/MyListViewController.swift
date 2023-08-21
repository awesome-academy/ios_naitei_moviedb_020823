import UIKit

final class MyListViewController: UIViewController {
    @IBOutlet private weak var myListCollectionView: UICollectionView!
    @IBOutlet private weak var backButton: UIButton!
    
    private var myMovies = [Movie]()
    weak var delegate: MovieTableViewCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
}

extension MyListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if myMovies.isEmpty { return Constants.defaultNumOfRows } else { return myMovies.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = myListCollectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.collectionViewCell.getIdentifier(), for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        if myMovies.isEmpty { return cell } else { cell.setCollectionViewCell(item: myMovies[indexPath.item]) }
        return cell
    }
}

extension MyListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if myMovies.isEmpty { delegate?.didSelectMovie(myMovies[indexPath.item]) } else { return }
    }
}

extension MyListViewController: MovieTableViewCellDelegate {
    func didSelectMovie(_ movie: Movie) {
        let storyBoard = UIStoryboard(name: "DetailScreen", bundle: nil)
        guard let detailScreen = storyBoard.instantiateViewController(withIdentifier: "DetailScreenViewController") as? DetailScreenViewController else { return }
        detailScreen.bindData(movie: movie, sender: SendingAddress.homeScreen)
        detailScreen.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }
}
