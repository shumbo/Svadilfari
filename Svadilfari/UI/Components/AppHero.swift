//
//  AppHero.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/09/16.
//

import SwiftUI

struct AppHero: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("Icon").resizable().frame(width: 160, height: 160).cornerRadius(28)
            Text("Svadilfari").font(.title).fontWeight(.bold)
        }
    }
}

struct AppHero_Previews: PreviewProvider {
    static var previews: some View {
        AppHero()
    }
}
