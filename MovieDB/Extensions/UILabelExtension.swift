import Foundation
import UIKit

extension UILabel {
    func formatDate(from inputFormat: String, to outputFormat: String) {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        if let date = inputFormatter.date(from: self.text ?? "") {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = outputFormat
            self.text = outputFormatter.string(from: date)
        } else {
            self.text = ""
        }
    }
}
