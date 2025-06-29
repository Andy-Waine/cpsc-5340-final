//
//  LostAndFoundApp.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI
import FirebaseCore

@main
struct LostAndFoundApp: App {
  init() {
    FirebaseApp.configure()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
