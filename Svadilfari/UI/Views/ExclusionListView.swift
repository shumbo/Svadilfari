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
            Section(footer: Text("Svadilfari will not detect gestures in the above domains or pages")) {
                ForEach(entries) { entry in
                    let str = "\(entry.domain ?? "")\(entry.path ?? "")"
                    Text(str)
                }.onDelete(perform: self.removeListEntry)
            }
        }.emptyPlaceholder(self.entries) {
            VStack {
                Spacer()
                Text("Add domains and websites to the exclusion list to disable gestures.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                Link("Read More", destination: URL(string: "https://docs.svadilfari.app/guide/exclusion-list")!)
                Spacer()
            }
        }.navigationTitle("Exclusion List")
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
