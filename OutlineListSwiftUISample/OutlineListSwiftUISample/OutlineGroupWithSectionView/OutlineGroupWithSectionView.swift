//
//  OutlineGroupWithSectionView.swift
//  OutlineListSwiftUISample
//
//  Created by Kojiro Yokota on 2021/02/13.
//

import SwiftUI

struct OutlineGroupWithSectionView: View {
    let viewModel = OutlineGroupWithSectionViewModel()

    var body: some View {
        List {
            ForEach(viewModel.items) { sectionHeader in
                Section(header: Text(sectionHeader.title)) {
                    OutlineGroup(sectionHeader.children ?? [], children: \.children) { item in
                        Text(item.title)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("OutlineGroupWithSectionView", displayMode: .inline)
    }
}

struct OutlineGroupWithSectionView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineGroupWithSectionView()
    }
}
