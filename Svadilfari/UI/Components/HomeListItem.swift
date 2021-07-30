//
//  HomeListItem.swift
//  HomeListItem
//
//  Created by Shun Kashiwa on 2021/07/30.
//

import SwiftUI

struct HomeListItem: View {
    public static let listRowInsets = EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
    
    var title: String
    var description: String
    var image: Image
    var imageColor: Color = Color.accentColor
    
    var body: some View {
        HStack(spacing: 0) {
            self.image.foregroundColor(self.imageColor).padding(.trailing, 8)
            VStack(alignment: .leading, spacing: 4) {
                Text(self.title)
                    .font(.body)
                Text(self.description).font(.caption).foregroundColor(.secondary)
            }
            Spacer()
        }.listRowInsets(Self.listRowInsets)
    }
}

struct HomeListItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HomeListItem(title: "Start Tutorial", description: "Learn how to use gestures", image: Image(systemName: "checkmark.circle.fill"), imageColor: .green)
            HomeListItem(title: "Start Tutorial", description: "Long text Long text Long text Long text Long text Long text Long text Long text ", image: Image(systemName: "checkmark.circle.fill"), imageColor: .pink)
        }
    }
}
