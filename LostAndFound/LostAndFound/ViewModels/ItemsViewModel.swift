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
      .addSnapshotListener { [weak self] snapshot, _ in
        guard let docs = snapshot?.documents else { return }
        self?.items = docs.compactMap { doc in
          let d = doc.data()
          guard
            let title = d["title"] as? String,
            let description = d["description"] as? String,
            let location = d["location"] as? String,
            let timestamp = d["date"] as? Timestamp,
            let type = d["type"] as? String,
            let postedBy = d["postedBy"] as? String,
            let postedByEmail = d["postedByEmail"] as? String
          else { return nil }

          return LostFoundItem(
            id: doc.documentID,
            title: title,
            description: description,
            location: location,
            date: timestamp.dateValue(),
            type: type,
            postedBy: postedBy,
            postedByEmail: postedByEmail
          )
        }
      }
  }

  deinit {
    listener?.remove()
  }
}

