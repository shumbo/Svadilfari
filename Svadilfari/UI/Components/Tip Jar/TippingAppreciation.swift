//
//  TippingAppreciation.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2022/08/09.
//

import SwiftUI

struct TippingAppreciation: View {
    let onContinue: () -> Void
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(Color.pink).padding(.bottom, 16)
            Text("TIP_JAR_APPRECIATION_TITLE").font(.title).bold().multilineTextAlignment(.center)
            Text("TIP_JAR_APPRECIATION_MESSAGE")
                .font(.body).multilineTextAlignment(.center)
            Button(action: {
                self.onContinue()
            }, label: {
                Text("TIP_JAR_APPRECIATION_CONTINUE").frame(maxWidth: .infinity).frame(height: 32)
            })
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
            .padding(.top, 16)
            Link("TIP_JAR_APPRECIATION_SEND_FEEDBACK", destination: URL(string: "https://go.svadilfari.app/contact")!)
        }.padding(.all, 24).frame(maxWidth: 480)
    }
}

struct TippingAppreciation_Previews: PreviewProvider {
    static var previews: some View {
        TippingAppreciation(onContinue: {
            print("continue")
        })
    }
}
