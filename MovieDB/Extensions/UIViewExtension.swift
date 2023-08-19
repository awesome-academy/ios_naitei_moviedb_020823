import Foundation
import UIKit

extension UIView {
    func roundedCorners() {
        layer.cornerRadius = 6
    }
    
    func circleView() {
        layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
