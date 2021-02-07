//
//  OutlineListSwiftUISampleApp.swift
//  OutlineListSwiftUISample
//
// Created by Kojiro Yokota on 2021/02/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SimpleOutlineView()) {
                    Text("SimpleOutlineView")
                }

                NavigationLink(destination: OutlineGroupWithSectionView()) {
                    Text("OutlineGroupWithSectionView")
                }

                NavigationLink(destination: DisclosureGroupWithSectionView()) {
                    Text("DisclosureGroupWithSectionView")
                }
            }
            .navigationBarTitle("SwiftUI Outline List sample", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
