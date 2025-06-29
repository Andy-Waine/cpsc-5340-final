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
  @Environment(\.presentationMode) var presentationMode

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
          TextField("Location", text: $vm.location)
          DatePicker("Date", selection: $vm.date, displayedComponents: .date)
          TextEditor(text: $vm.description)
            .frame(height: 100)
        }

        Section {
          Button("Save") {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            vm.save(postedBy: uid) { _ in
              presentationMode.wrappedValue.dismiss()
            }
          }
          .disabled(vm.title.isEmpty || vm.location.isEmpty)
        }
      }
      .navigationTitle("Post Item")
    }
  }
}
