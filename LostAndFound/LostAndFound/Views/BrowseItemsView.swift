//
//  BrowseItemsView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI

struct BrowseItemsView: View {
  @StateObject private var vm = ItemsViewModel()

  var body: some View {
    NavigationView {
      VStack {
        Picker("Type", selection: $vm.filterType) {
          Text("Lost").tag("lost")
          Text("Found").tag("found")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .onChange(of: vm.filterType) { _ in
          vm.fetchItems()
        }

        List(vm.items) { item in
          NavigationLink(destination: ItemDetailView(item: item)) {
            VStack(alignment: .leading) {
              Text(item.title).font(.headline)
              Text(item.location).font(.subheadline)
              Text(item.date, style: .date).font(.caption)
            }
          }
        }
      }
      .navigationTitle("Campus Lost & Found")
      .onAppear { vm.fetchItems() }
    }
  }
}
