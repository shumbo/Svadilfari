//
//  ContentView.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI

struct ContentView: View {
    @StateObject var store: IAPStore = IAPStore()

    var body: some View {
        HomeListView()
            .environmentObject(store)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
