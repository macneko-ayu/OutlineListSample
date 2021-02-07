//
//  DisclosureGroupWithSectionView.swift
//  OutlineListSwiftUISample
//
//  Created by Kojiro Yokota on 2021/02/13.
//

import SwiftUI

struct DisclosureGroupWithSectionView: View {
    let viewModel = DisclosureGroupWithSectionViewModel()

    var body: some View {
        List {
            ForEach(viewModel.items) { sectionHeader in
                Section(header: Text(sectionHeader.title)) {
                    ForEach(sectionHeader.children) { header in
                        DisclosureGroup {
                            ForEach(header.children) { child in
                                Text(child.title)
                            }
                        } label: {
                            Text(header.title)
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("DisclosureGroupWithSectionView", displayMode: .inline)
    }
}

struct DisclosureGroupWithSectionView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureGroupWithSectionView()
    }
}
