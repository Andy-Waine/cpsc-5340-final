//
//  LoginView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI

struct LoginView: View {
  @ObservedObject var viewModel: AuthViewModel
  @Binding var toggleSignUp: Bool

  var body: some View {
    VStack(spacing: 20) {
      Text("Login")
        .font(.largeTitle).bold()

      TextField("Email", text: $viewModel.email)
        .disableAutocorrection(true)
        .textFieldStyle(RoundedBorderTextFieldStyle())

      SecureField("Password", text: $viewModel.password)
        .disableAutocorrection(true)
        .textFieldStyle(RoundedBorderTextFieldStyle())

      if let error = viewModel.errorMessage {
        Text(error)
          .foregroundColor(.red)
      }

      Button("Sign In") {
        viewModel.signIn()
      }
      .buttonStyle(.borderedProminent)

      Button("Don't have an account? Sign Up") {
        toggleSignUp = true
      }
      .buttonStyle(.bordered)
    }
    .padding()
  }
}

