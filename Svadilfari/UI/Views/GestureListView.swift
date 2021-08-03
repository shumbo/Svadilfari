//
//  GestureListView.swift
//  GestureListView
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI

struct GestureListView: View {
    var body: some View {
        Text("Hello World")
            .navigationBarHidden(false)
            .navigationBarTitle("Gesture")
            .navigationBarItems(trailing: Button("+") {
                print("add")
            })
    }
}

struct GestureListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GestureListView()
        }
    }
}
