//
//  PostItemViewModel.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import Foundation
import FirebaseFirestore

class PostItemViewModel: ObservableObject {
  @Published var title = ""
  @Published var description = ""
  @Published var location = ""
  @Published var date = Date()
  @Published var type = "lost"

  private var db = Firestore.firestore()

  func save(postedBy uid: String, completion: @escaping (Result<Void, Error>) -> Void) {
    let data: [String: Any] = [
      "title": title,
      "description": description,
      "location": location,
      "date": Timestamp(date: date),
      "type": type,
      "postedBy": uid
    ]

    db.collection("items").addDocument(data: data) { error in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(()))
      }
    }
  }
}
