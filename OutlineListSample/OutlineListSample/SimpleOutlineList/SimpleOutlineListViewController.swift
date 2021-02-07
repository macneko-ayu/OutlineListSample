//
//  SimpleOutlineListViewController.swift
//  OutlineListSample
//
//  Created by Kojiro Yokota on 2021/02/06.
//

import UIKit

final class SimpleOutlineListViewController: UIViewController {
    typealias Section = SimpleOutlineListViewModel.Section
    typealias Item = SimpleOutlineListViewModel.Item

    @IBOutlet var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private let viewModel = SimpleOutlineListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SimpleOutlineList"
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        applyInitialSnapshots()
    }
}

extension SimpleOutlineListViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func createHeaderCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, _, title) in
            var content = cell.defaultContentConfiguration()
            content.text = title
            cell.contentConfiguration = content
            cell.accessories = [.outlineDisclosure(options: .init(style: .header))]
        }
    }

    private func createCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, _, title) in
            var content = cell.defaultContentConfiguration()
            content.text = title
            cell.contentConfiguration = content
            cell.accessories = [.reorder()]
        }
    }

    private func configureDataSource() {
        let headerCellRegistration = createHeaderCellRegistration()
        let cellRegistration = createCellRegistration()

        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            if item.hasChildren {
                return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: item.title)
            }
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item.title)
        }
    }

    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSectionSnapshot<Item>()

        func addItems(_ menuItems: [Item], to parent: Item?) {
            snapshot.append(menuItems, to: parent)
            for menuItem in menuItems where menuItem.hasChildren {
                addItems(menuItem.children, to: menuItem)
            }
        }

        addItems(viewModel.items, to: nil)
        dataSource.apply(snapshot, to: .main, animatingDifferences: false)
    }
}
