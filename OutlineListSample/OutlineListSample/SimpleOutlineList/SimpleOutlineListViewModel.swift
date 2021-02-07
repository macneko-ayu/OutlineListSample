//
//  SimpleOutlineListViewModel.swift
//  OutlineListSample
//
// Created by Kojiro Yokota on 2021/02/06.
//

import Foundation

struct SimpleOutlineListViewModel {
    let items: [Item]

    init() {
        var items: [Item] = []
        Kind.allCases.forEach { kind in
            switch kind {
            case .animal:
                let headers = Animal.allCases.map { animal -> Item in
                    return Item(title: animal.description, children: animal.names.map { Item(title: $0, children: []) })
                }
                items.append(Item(title: kind.description, children: headers))
            case .food:
                let headers = Food.allCases.map { food -> Item in
                    return Item(title: food.description, children: food.names.map { Item(title: $0, children: []) })
                }
                items.append(Item(title: kind.description, children: headers))
            }
        }
        self.items = items
    }
}

extension SimpleOutlineListViewModel {
    enum Section: Hashable {
        case main
    }

    struct Item: Hashable {
        private let identifier = UUID()
        let title: String
        let children: [Item]
        var hasChildren: Bool {
            return !children.isEmpty
        }
    }
}
