//
//  ExclusionListView.swift
//  ExclusionListView
//
//  Created by Shun Kashiwa on 2021/08/18.
//

import SwiftUI
import CoreData

struct ExclusionListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ExclusionListEntryEntity.entity(), sortDescriptors: [], predicate: nil, animation: .default)
    private var fetchedResult: FetchedResults<ExclusionListEntryEntity>

    @State private var count = 0

    private var exclusionList: [String]? {
        guard let e = self.fetchedResult.first, let json = e.json else {
            return nil
        }
        guard let list = try? ExclusionList(json) else {
            return nil
        }
        return list
    }

    var body: some View {
        List {
            ForEach(exclusionList ?? ["hello"], id: \.self) { entry in
                Text(entry)
            }
        }.refreshable {
            print("refresh")
            self.fetchedResult.first?.objectWillChange.send()
        }.navigationTitle("Exclusion List")
    }
}

struct ExclusionListView_Previews: PreviewProvider {
    static var previews: some View {
        ExclusionListView()
    }
}
