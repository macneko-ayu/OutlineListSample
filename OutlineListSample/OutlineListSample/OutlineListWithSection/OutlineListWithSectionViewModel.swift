//
//  OutlineListWithSectionViewModel.swift
//  OutlineListSample
//
// Created by Kojiro Yokota on 2021/02/06.
//

import Foundation

struct OutlineListWithSectionViewModel {
    let items: [SectionHeader]

    init() {
        var items: [SectionHeader] = []
        Kind.allCases.forEach { kind in
            switch kind {
            case .animal:
                let headers = Animal.allCases.map { animal -> Header in
                    return Header(title: animal.description, children: animal.names.map { Children(title: $0) })
                }
                items.append(SectionHeader(title: kind.description, headers: headers))
            case .food:
                let headers = Food.allCases.map { food -> Header in
                    return Header(title: food.description, children: food.names.map { Children(title: $0) })
                }
                items.append(SectionHeader(title: kind.description, headers: headers))
            }
        }
        self.items = items
    }
}

extension OutlineListWithSectionViewModel {
    enum ListItem: Hashable {
        case sectionHeader(SectionHeader)
        case header(Header)
        case children(Children)
    }

    struct SectionHeader: Hashable {
        private let identifier = UUID()
        let title: String
        let headers: [Header]
    }

    struct Header: Hashable {
        private let identifier = UUID()
        let title: String
        let children: [Children]
    }

    struct Children: Hashable {
        private let identifier = UUID()
        let title: String
    }
}
