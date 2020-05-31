import UIKit

final class MoviesView: UITableView {
    
    var onScrollAtEnd: VoidClosure?
    
    private enum Section {
        case main
    }
    
    private var diffableDataSource: UITableViewDiffableDataSource<Section, MovieViewCellInputData>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate = self
        
        register(nibType: MovieViewCell.self)
        
        diffableDataSource = UITableViewDiffableDataSource<Section, MovieViewCellInputData>(tableView: self) { table, index, data in
            table.dequeueReusableCell(withType: MovieViewCell.self, for: index).udapte(with: data)
        }
    }
    
    func update(cellData: [MovieViewCellInputData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieViewCellInputData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellData, toSection: .main)
        diffableDataSource?.apply(snapshot)
    }
    
}

extension MoviesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        diffableDataSource?.itemIdentifier(for: indexPath)?.onSelect()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        // SO`code DONT USE IN PRODUCTION (:
        let contentSize = scrollView.contentSize.height
        let tableSize = scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom
        let canLoadFromBottom = contentSize > tableSize

        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let difference = maximumOffset - currentOffset

        if canLoadFromBottom, difference <= -120.0 {
            onScrollAtEnd?()
        }
        
    }
    
}


