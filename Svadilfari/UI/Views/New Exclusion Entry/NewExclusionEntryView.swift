//
//  NewExclusionEntryView.swift
//  NewExclusionEntryView
//
//  Created by Shun Kashiwa on 2021/08/21.
//

import SwiftUI

struct NewExclusionEntryView: View {
    @State private var domain = ""
    @State private var path = ""

    var onCancel: () -> Void
    var onCreate: (String, String?) -> Void

    var body: some View {
        Form {
            Section(
                header: Text("Domain"),
                footer: Text("Enter the domain to disable the gesture.")
            ) {
                TextField("example.com", text: $domain)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.URL)
            }
            Section(
                header: Text("Path"),
                footer: Text("Enter the path to disable the gesture. Leave this field empty to disable for all paths on the domain.") // swiftlint:disable:this line_length
            ) {
                TextField("/video", text: $path)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.URL)
            }
        }.navigationTitle("Add to Exclusion List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.onCancel()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if path.isEmpty {
                            self.onCreate(self.domain, nil)
                            return
                        }
                        if !path.starts(with: "/") {
                            path = "/" + path
                        }
                        self.onCreate(self.domain, self.path)
                    }.disabled(self.domain.isEmpty)
                }
            }
    }
}

struct NewExclusionEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewExclusionEntryView(onCancel: {
                print("Cancelled")
            }, onCreate: { domain, path in
                print("Create \(domain) \(path ?? "")")
            })
        }
    }
}
