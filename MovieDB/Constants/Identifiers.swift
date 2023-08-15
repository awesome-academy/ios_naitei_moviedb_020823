import Foundation

enum Identifiers {
    case tableViewCell
    case collectionViewCell
    
    func getIdentifier() -> String {
        switch self {
        case .tableViewCell:
            return "MovieTableViewCell"
        case .collectionViewCell:
            return "MovieCollectionViewCell"
        }
    }
}
