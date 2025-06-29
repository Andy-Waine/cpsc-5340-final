//
//  ItemsViewModel.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import Foundation
import FirebaseFirestore

class ItemsViewModel: ObservableObject {
  @Published var items: [LostFoundItem] = []
  @Published var filterType: String = "lost"

  private var db = Firestore.firestore()
  private var listener: ListenerRegistration?

  func fetchItems() {
    listener?.remove()
    listener = db.collection("items")
      .whereField("type", isEqualTo: filterType)
      .order(by: "date", descending: true)
      .addSnapshotListener { [weak self] snapshot, error in
        guard let docs = snapshot?.documents else { return }
        self?.items = docs.compactMap { doc in
          let data = doc.data()
          guard
            let title = data["title"] as? String,
            let description = data["description"] as? String,
            let location = data["location"] as? String,
            let timestamp = data["date"] as? Timestamp,
            let type = data["type"] as? String,
            let postedBy = data["postedBy"] as? String
          else { return nil }

          return LostFoundItem(
            id: doc.documentID,
            title: title,
            description: description,
            location: location,
            date: timestamp.dateValue(),
            type: type,
            postedBy: postedBy
          )
        }
      }
  }

  deinit {
    listener?.remove()
  }
}

