//
//  ListViewModel.swift
//  OutlineListSample
//
//  Created by Kojiro Yokota on 2021/02/17.
//

import Foundation

struct ListViewModel {
    enum Section: Hashable {
        case main
    }

    enum RowType: Hashable, CaseIterable {
        case simple, withSection

        var description: String {
            switch self {
            case .simple:
                return "SimpleOutlineList"
            case .withSection:
                return "OutlineListWithSection"
            }
        }
    }
}
