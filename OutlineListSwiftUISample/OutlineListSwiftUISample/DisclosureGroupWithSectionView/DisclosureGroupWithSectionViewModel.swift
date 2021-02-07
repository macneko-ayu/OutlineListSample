//
//  DisclosureGroupWithSectionViewModel.swift
//  OutlineListSwiftUISample
//
// Created by Kojiro Yokota on 2021/02/06.
//

import Foundation

struct DisclosureGroupWithSectionViewModel {
    let items: [SectionHeader]

    init() {
        var items: [SectionHeader] = []
        Kind.allCases.forEach { kind in
            switch kind {
            case .animal:
                let headers = Animal.allCases.map { animal -> Header in
                    return Header(title: animal.description, children: animal.names.map { Children(title: $0) })
                }
                items.append(SectionHeader(title: kind.description, children: headers))
            case .food:
                let headers = Food.allCases.map { food -> Header in
                    return Header(title: food.description, children: food.names.map { Children(title: $0) })
                }
                items.append(SectionHeader(title: kind.description, children: headers))
            }
        }
        self.items = items
    }
}

extension DisclosureGroupWithSectionViewModel {
    struct SectionHeader: Identifiable {
        let id = UUID()
        let title: String
        let children: [Header]
    }

    struct Header: Identifiable {
        let id = UUID()
        let title: String
        let children: [Children]
    }

    struct Children: Identifiable {
        let id = UUID()
        let title: String
    }
}
