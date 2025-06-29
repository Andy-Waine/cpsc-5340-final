//
//  AuthenticationService.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import Foundation
import FirebaseAuth

class AuthenticationService {
  func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
      if let user = authResult?.user {
        completion(.success(user))
      } else if let error = error {
        completion(.failure(error))
      }
    }
  }

  func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      if let user = authResult?.user {
        completion(.success(user))
      } else if let error = error {
        completion(.failure(error))
      }
    }
  }

  func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
    do {
      try Auth.auth().signOut()
      completion(.success(()))
    } catch {
      completion(.failure(error))
    }
  }
}

