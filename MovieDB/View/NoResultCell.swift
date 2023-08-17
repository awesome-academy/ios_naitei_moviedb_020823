import UIKit

final class NoResultCell: UITableViewCell {
    @IBOutlet private weak var noResultImage: UIImageView!
    @IBOutlet private weak var noResultLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
