//
//  OutlineListWithSectionViewController.swift
//  OutlineListSample
//
//  Created by Kojiro Yokota on 2021/02/06.
//

import UIKit

final class OutlineListWithSectionViewController: UIViewController {
    typealias ListItem = OutlineListWithSectionViewModel.ListItem
    typealias SectionHeader = OutlineListWithSectionViewModel.SectionHeader
    typealias Header = OutlineListWithSectionViewModel.Header
    typealias Children = OutlineListWithSectionViewModel.Children

    @IBOutlet var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<SectionHeader, ListItem>!
    private let viewModel = OutlineListWithSectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "OutlineListWithSection"
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        applyInitialSnapshots()
    }
}

extension OutlineListWithSectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (_: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
            config.headerMode = .firstItemInSection
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
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
            let marginLeft = content.directionalLayoutMargins.leading + content.textProperties.font.pointSize
            content.directionalLayoutMargins = .init(top: 0, leading: marginLeft,  bottom: 0, trailing: 0)
            cell.contentConfiguration = content
            cell.accessories = [.reorder()]
        }
    }

    private func createSectionHeaderRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, _, title) in
            var content = cell.defaultContentConfiguration()
            content.text = title
            content.textProperties.font = .boldSystemFont(ofSize: 16)
            content.textProperties.color = .systemBlue
            cell.contentConfiguration = content
        }
    }

    private func configureDataSource() {
        let sectionHeaderRegistration = createSectionHeaderRegistration()
        let headerCellRegistration = createHeaderCellRegistration()
        let cellRegistration = createCellRegistration()

        dataSource = UICollectionViewDiffableDataSource<SectionHeader, ListItem>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case let .sectionHeader(model):
                return collectionView.dequeueConfiguredReusableCell(using: sectionHeaderRegistration, for: indexPath, item: model.title)
            case let .header(model):
                return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: model.title)
            case let .children(model):
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: model.title)
            }
        }
    }

    private func applyInitialSnapshots() {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionHeader, ListItem>()

        dataSourceSnapshot.appendSections(viewModel.items)
        dataSource.apply(dataSourceSnapshot)

        for sectionHeader in viewModel.items {
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()

            let sectionHeaderItem = ListItem.sectionHeader(sectionHeader)
            sectionSnapshot.append([sectionHeaderItem])

            sectionHeader.headers.forEach { header in
                let headerItem = ListItem.header(header)
                let childrenItems = header.children.map { ListItem.children($0) }
                sectionSnapshot.append([headerItem])
                sectionSnapshot.append(childrenItems, to: headerItem)
            }

            dataSource.apply(sectionSnapshot, to: sectionHeader, animatingDifferences: false)
        }
    }
}
