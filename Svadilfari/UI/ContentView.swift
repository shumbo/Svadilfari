//
//  ContentView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI

struct ContentView: View {
    @State private var store = IAPStore()

    var body: some View {
        HomeListView()
            .environment(store)
    }
}

#Preview {
    ContentView()
}
