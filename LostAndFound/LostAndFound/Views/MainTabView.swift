//
//  MainTabView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI

struct MainTabView: View {
  @ObservedObject var authViewModel: AuthViewModel

  var body: some View {
    TabView {
      BrowseItemsView()
        .tabItem {
          Label("Browse", systemImage: "list.bullet")
        }

      PostItemView()
        .tabItem {
          Label("Post", systemImage: "plus.circle")
        }

      AccountView(authViewModel: authViewModel)
        .tabItem {
          Label("Account", systemImage: "person.crop.circle")
        }
    }
  }
}
