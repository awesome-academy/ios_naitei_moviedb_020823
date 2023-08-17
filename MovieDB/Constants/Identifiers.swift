import Foundation

enum Identifiers {
    case tableViewCell
    case collectionViewCell
    case searchTableViewCell
    
    func getIdentifier() -> String {
        switch self {
        case .tableViewCell:
            return "MovieTableViewCell"
        case .collectionViewCell:
            return "MovieCollectionViewCell"
        case .searchTableViewCell:
            return "SearchTableViewCell"
        }
    }
}
