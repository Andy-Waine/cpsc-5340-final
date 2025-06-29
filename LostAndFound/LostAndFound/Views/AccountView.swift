//
//  AccountView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
  @ObservedObject var authViewModel: AuthViewModel
  @State private var showLogoutConfirmation = false

  var body: some View {
    let user = Auth.auth().currentUser
    let email = user?.email ?? "N/A"
    let uid = user?.uid ?? "N/A"
    let creationDate = user?.metadata.creationDate ?? Date()

    NavigationView {
      ZStack {
        Color(UIColor.systemGray6)
          .ignoresSafeArea()

        VStack(spacing: 30) {
          VStack(alignment: .leading, spacing: 16) {
            Group {
              Text("E-mail:")
                .font(.headline)
              Text(email)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }

            Group {
              Text("Created On:")
                .font(.headline)
              Text(creationDate, style: .date)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }

            Group {
              Text("User ID:")
                .font(.headline)
              Text(uid)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
          }
          .padding(.horizontal, 20)
          Spacer()
          Button("Logout") {
            showLogoutConfirmation = true
          }
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.white)
          .foregroundColor(.red)
          .cornerRadius(8)
          .padding(.horizontal, 20)
        }
        .padding(.top, 20)
      }
      .navigationTitle("Account Details")
      .alert("Confirm Logout", isPresented: $showLogoutConfirmation) {
        Button("Confirm", role: .destructive) {
          authViewModel.signOut()
        }
        Button("Cancel", role: .cancel) { }
      } message: {
        Text("Do you really want to log out?")
      }
    }
  }
}
