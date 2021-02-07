//
//  SimpleOutlineViewModel.swift
//  OutlineListSwiftUISample
//
// Created by Kojiro Yokota on 2021/02/06.
//

import Foundation

struct SimpleOutlineViewModel {
    let items: [Item]

    init() {
        var items: [Item] = []
        Kind.allCases.forEach { kind in
            switch kind {
            case .animal:
                let headers = Animal.allCases.map { animal -> Item in
                    return Item(title: animal.description, children: animal.names.map { Item(title: $0) })
                }
                items.append(Item(title: kind.description, children: headers))
            case .food:
                let headers = Food.allCases.map { food -> Item in
                    return Item(title: food.description, children: food.names.map { Item(title: $0) })
                }
                items.append(Item(title: kind.description, children: headers))
            }
        }
        self.items = items
    }
}

extension SimpleOutlineViewModel {
    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let children: [Item]?

        init(title: String, children: [Item]? = nil) {
            self.title = title
            self.children = children
        }
    }
}
