import UIKit

class DetailScreenViewController: UIViewController {
    @IBOutlet private weak var backButton: UIButton!
    
    private var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindData(movie: Movie) {
        self.movie = movie
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
}
