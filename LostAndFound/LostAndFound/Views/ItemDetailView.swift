//
//  ItemDetailView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI

struct ItemDetailView: View {
  let item: LostFoundItem

  var body: some View {
    VStack(spacing: 16) {
      Text(item.title).font(.largeTitle).bold()
      Text(item.type.capitalized).font(.subheadline).foregroundColor(.secondary)
      Text("Location: \(item.location)").font(.body)
      Text("Date: \(item.date, style: .date)").font(.body)
      Divider()
      Text(item.description).font(.body)
      Spacer()
    }
    .padding()
    .navigationTitle("Details")
  }
}
