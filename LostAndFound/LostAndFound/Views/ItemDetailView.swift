//
//  ItemDetailView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ItemDetailView: View {
  let item: LostFoundItem
  @Environment(\.presentationMode) private var presentationMode
  @State private var showDeleteConfirmation = false

  var body: some View {
    VStack(spacing: 16) {
      Text(item.title)
        .font(.largeTitle)
        .bold()

      Text(item.type.capitalized)
        .font(.subheadline)
        .foregroundColor(.secondary)

      Text("Location: \(item.location)")
        .font(.body)
      Text("Date: \(item.date, style: .date)")
        .font(.body)
      Text("Posted by: \(item.postedByEmail)")
        .font(.body)

      Divider()

      Text(item.description)
        .font(.body)

      Spacer()

      if let id = item.id, Auth.auth().currentUser?.uid == item.postedBy {
        Button("Delete") {
          showDeleteConfirmation = true
        }
        .foregroundColor(.red)
        .padding(.bottom, 20)
        .alert("Confirm Delete", isPresented: $showDeleteConfirmation) {
          Button("Delete", role: .destructive) {
            let db = Firestore.firestore()
            db.collection("items")
              .document(id)
              .delete { _ in
                presentationMode.wrappedValue.dismiss()
              }
          }
          Button("Cancel", role: .cancel) { }
        } message: {
          Text("Are you sure you wish to delete this entry?")
        }
      }
    }
    .padding()
    .navigationTitle("Details")
  }
}
