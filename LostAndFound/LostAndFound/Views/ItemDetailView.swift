//
//  ItemDetailView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import UIKit

struct ItemDetailView: View {
  let item: LostFoundItem
  @Environment(\.presentationMode) private var presentationMode
  @State private var showDeleteConfirmation = false
  @State private var showCopyNotification = false

  var body: some View {
    ZStack {
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

        HStack {
          Text("Created by:")
            .font(.body)
          Text(item.postedByEmail)
            .font(.body)
          Button {
            UIPasteboard.general.string = item.postedByEmail
            showCopyNotification = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              showCopyNotification = false
            }
          } label: {
            Image(systemName: "doc.on.clipboard")
          }
        }

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

      if showCopyNotification {
        VStack {
          Spacer()
          Text("Copied to clipboard")
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.black.opacity(0.75))
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.bottom, 40)
        }
        .transition(.opacity)
      }
    }
  }
}
