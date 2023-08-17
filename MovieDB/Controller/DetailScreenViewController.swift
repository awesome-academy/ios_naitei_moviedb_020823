import UIKit

class DetailScreenViewController: UIViewController {
    @IBOutlet private weak var backButton: UIButton!
    
    private var movie: Movie?
    private var sender: SendingAddress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configButton()
    }
    
    private func configButton() {
        switch sender {
        case .homeScreen:
            backButton.isEnabled = true
            backButton.isHidden = false
        case .searchScreen:
            backButton.isEnabled = false
            backButton.isHidden = true
        case .none:
            backButton.isEnabled = false
            backButton.isHidden = true
        }
    }
    
    func bindData(movie: Movie, sender: SendingAddress) {
        self.movie = movie
        self.sender = sender
    }
    
    @IBAction private func backButtonTapped(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
}
