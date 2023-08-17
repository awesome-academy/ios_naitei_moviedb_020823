import UIKit

final class SearchTableViewCell: UITableViewCell {
    @IBOutlet private weak var moviePosterImage: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    
    private var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSearchTableViewCell(movie: Movie) {
        self.movie = movie
    }
}
