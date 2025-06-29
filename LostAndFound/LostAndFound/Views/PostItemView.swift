//
//  PostItemView.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import SwiftUI
import FirebaseAuth

struct PostItemView: View {
  @StateObject private var vm = PostItemViewModel()
  @State private var postSuccess = false

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Type")) {
          Picker("Type", selection: $vm.type) {
            Text("Lost").tag("lost")
            Text("Found").tag("found")
          }
          .pickerStyle(SegmentedPickerStyle())
        }

        Section(header: Text("Details")) {
          TextField("Title", text: $vm.title)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
          TextField("Location", text: $vm.location)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
          DatePicker("Date", selection: $vm.date, displayedComponents: .date)
          ZStack(alignment: .topLeading) {
            if vm.description.isEmpty {
              Text("Description")
                .foregroundColor(.gray)
                .padding(.top, 8)
                .padding(.leading, 4)
            }
            TextEditor(text: $vm.description)
              .frame(height: 100)
          }
        }

        Section {
          Button("Post") {
            postSuccess = false
            guard let uid = Auth.auth().currentUser?.uid else { return }
            vm.save(postedBy: uid) { result in
              switch result {
              case .success:
                vm.title = ""
                vm.location = ""
                vm.description = ""
                vm.date = Date()
                vm.type = "lost"
                postSuccess = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                  postSuccess = false
                }
              case .failure:
                break
              }
            }
          }
          .disabled(vm.title.isEmpty || vm.location.isEmpty)
        }

        if postSuccess {
          Section {
            Text("Post Successful!")
              .foregroundColor(.green)
          }
        }
      }
      .navigationTitle("Post Item")
    }
  }
}
