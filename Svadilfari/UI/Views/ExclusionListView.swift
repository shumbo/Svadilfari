//
//  ExclusionListView.swift
//  ExclusionListView
//
//  Created by Shun Kashiwa on 2021/08/18.
//

import SwiftUI
import CoreData
import os

struct ExclusionListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: ExclusionEntryEntity.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "domain", ascending: true),
            NSSortDescriptor(key: "path", ascending: true)
        ],
        predicate: nil,
        animation: .default
    )
    private var entries: FetchedResults<ExclusionEntryEntity>

    var body: some View {
        List {
            Section(footer: Text("EXCLUSION_LIST_FOOTER")) {
                ForEach(entries) { entry in
                    let str = "\(entry.domain ?? "")\(entry.path ?? "")"
                    Text(str)
                }.onDelete(perform: self.removeListEntry)
            }
        }.emptyPlaceholder(self.entries) {
            VStack {
                Spacer()
                Text("EXCLUSION_LIST_EMPTY_MESSAGE")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                Link(
                    "EXCLUSION_LIST_READ_MORE",
                    destination: URL(string: "https://go.svadilfari.app/exclusion-list")!
                )
                Spacer()
            }
        }.navigationTitle("EXCLUSION_LIST_TITLE")
    }

    func removeListEntry(offsets: IndexSet) {
        withAnimation {
            offsets.map { self.entries[$0] }.forEach(self.viewContext.delete)
            do {
                try self.viewContext.save()
            } catch {
                Logger.coreData.error("\(error.localizedDescription, privacy: .public)")
            }
        }
    }
}

struct ExclusionListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExclusionListView()
        }
    }
}
