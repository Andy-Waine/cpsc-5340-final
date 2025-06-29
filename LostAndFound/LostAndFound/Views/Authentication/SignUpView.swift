//
//  SignUpView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//
import SwiftUI

struct SignUpView: View {
  @ObservedObject var viewModel: AuthViewModel
  @Binding var toggleSignUp: Bool
  @State private var confirmPassword = ""

  var body: some View {
    VStack(spacing: 20) {
      Text("Sign Up")
        .font(.largeTitle).bold()

      TextField("Email", text: $viewModel.email)
        .disableAutocorrection(true)
        .textFieldStyle(RoundedBorderTextFieldStyle())

      SecureField("Password", text: $viewModel.password)
        .disableAutocorrection(true)
        .textFieldStyle(RoundedBorderTextFieldStyle())

      SecureField("Confirm Password", text: $confirmPassword)
        .disableAutocorrection(true)
        .textFieldStyle(RoundedBorderTextFieldStyle())

      if let error = viewModel.errorMessage {
        Text(error)
          .foregroundColor(.red)
      }

      Button("Create Account") {
        guard viewModel.password == confirmPassword else {
          viewModel.errorMessage = "Passwords do not match."
          return
        }
        viewModel.signUp()
      }
      .buttonStyle(.borderedProminent)

      Button("Already have an account? Login") {
        toggleSignUp = false
      }
      .buttonStyle(.bordered)
    }
    .padding()
  }
}
