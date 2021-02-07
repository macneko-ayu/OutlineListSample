//
//  ListViewController.swift
//  OutlineListSample
//
//  Created by Kojiro Yokota on 2021/02/17.
//
//

import UIKit

class ListViewController: UIViewController {
    typealias Section = ListViewModel.Section
    typealias RowType = ListViewModel.RowType

    @IBOutlet var collectionView: UICollectionView!

    private let viewModel = ListViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, RowType>!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Outline List Sample"
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        applyInitialSnapshots()
    }
}

extension ListViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func createCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, RowType> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, RowType> { (cell, _, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.description
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
        }
    }

    private func configureDataSource() {
        let cellRegistration = createCellRegistration()

        dataSource = UICollectionViewDiffableDataSource<Section, RowType>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }

    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RowType>()

        snapshot.appendSections([.main])
        snapshot.appendItems(RowType.allCases, toSection: .main)
        dataSource.apply(snapshot)
    }
}

extension ListViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)

        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch item {
        case .simple:
            let targetVC = storyboard.instantiateViewController(withIdentifier: "\(SimpleOutlineListViewController.self)")
            navigationController?.pushViewController(targetVC, animated: true)
        case .withSection:
            let targetVC = storyboard.instantiateViewController(withIdentifier: "\(OutlineListWithSectionViewController.self)")
            navigationController?.pushViewController(targetVC, animated: true)
        }
    }
}