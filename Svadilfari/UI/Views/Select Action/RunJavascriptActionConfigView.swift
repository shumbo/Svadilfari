//
//  RunJavascriptActionConfigView.swift
//  RunJavascriptActionConfigView
//
//  Created by Shun Kashiwa on 2021/08/06.
//

import SwiftUI

struct RunJavascriptActionConfigView: View {
    @State private var code: String = "alert(\"hello, world\")\n\n\n"
    @State private var description: String = ""

    let onSelect: SelectActionView.SelectActionCallback
    var body: some View {
        Form {
            Section(header: Text("JavaScript Code"), footer: Text("Enter the JavaScript code to be executed")) {
                ZStack {
                    TextEditor(text: self.$code)
                        .lineLimit(0)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    // create invisible text for dynamic height
                    // https://bit.ly/3CjKExM
                    Text(self.code).opacity(0).padding(.all, 8)
                }
            }
            Section(header: Text("Description"), footer: Text("Briefly describe the code")) {
                TextField("", text: $description)
            }
            Button(
                action: {
                    let runJS = JavascriptRun(code: self.code, javascriptRunDescription: self.description)
                    let action = Action(javascriptRun: runJS)
                    onSelect(action)
                },
                label: {
                    Text("Continue").bold().frame(maxWidth: .infinity)
                }
            ).buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .listRowInsets(EdgeInsets())
        }.navigationTitle("Run JavaScript")
    }
}

struct RunJavascriptActionConfigView_Previews: PreviewProvider {
    static var previews: some View {
        RunJavascriptActionConfigView(onSelect: { action in
            print("selected: \(action.label)")
        })
    }
}
