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

    let javascriptRun: JavascriptRun?
    let onSelect: (Action) -> Void

    var body: some View {
        Form {
            Section(header: Text("RUN_JAVASCRIPT_CONFIG_HEADER_1"), footer: Text("RUN_JAVASCRIPT_CONFIG_FOOTER_1")) {
                ZStack {
                    TextEditor(text: self.$code)
                        .lineLimit(0)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onAppear {
                            self.code = self.javascriptRun?.code ?? self.code
                        }
                    // create invisible text for dynamic height
                    // https://bit.ly/3CjKExM
                    Text(self.code).opacity(0).padding(.all, 8)
                }
            }
            Section(header: Text("RUN_JAVASCRIPT_CONFIG_HEADER_2"), footer: Text("RUN_JAVASCRIPT_CONFIG_FOOTER_2")) {
                TextField("", text: $description).onAppear {
                    self.description = self.javascriptRun?.javascriptRunDescription ?? self.description
                }
            }
            Button(
                action: {
                    let runJS = JavascriptRun(code: self.code, javascriptRunDescription: self.description)
                    let action = Action(javascriptRun: runJS)
                    onSelect(action)
                },
                label: {
                    Text(self.javascriptRun == nil ? "COMMON_CONTINUE" : "COMMON_SAVE")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
            ).buttonBorderShape(.roundedRectangle)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .listRowInsets(EdgeInsets())
        }.navigationTitle("RUN_JAVASCRIPT_CONFIG_TITLE")
            .interactiveDismissDisabled()
    }
}

struct RunJavascriptActionConfigView_Previews: PreviewProvider {
    static var previews: some View {
        RunJavascriptActionConfigView(javascriptRun: nil, onSelect: { action in
            print("selected: \(action.title)")
        })
    }
}
