import Foundation

enum Identifiers {
    case tableViewCell
    case collectionViewCell
    case searchTableViewCell
    case noResultCell
    
    func getIdentifier() -> String {
        switch self {
        case .tableViewCell:
            return "MovieTableViewCell"
        case .collectionViewCell:
            return "MovieCollectionViewCell"
        case .searchTableViewCell:
            return "SearchTableViewCell"
        case .noResultCell:
            return "NoResultCell"
        }
    }
}
