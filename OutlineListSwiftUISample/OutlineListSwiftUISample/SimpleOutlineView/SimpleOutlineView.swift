//
//  SimpleOutlineView.swift
//  OutlineListSwiftUISample
//
//  Created by Kojiro Yokota on 2021/02/13.
//

import SwiftUI

struct SimpleOutlineView: View {
    let viewModel = SimpleOutlineViewModel()

    var body: some View {
        List(viewModel.items, children: \.children) { item in
            Text(item.title)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("SimpleOutlineView", displayMode: .inline)
    }
}

struct SimpleOutlineView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleOutlineView()
    }
}
