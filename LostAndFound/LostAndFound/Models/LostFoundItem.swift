//
//  LostFoundItem.swift
//  LostAndFound
//
//  Created by Andy Waine on 6/29/25.
//

import Foundation

struct LostFoundItem: Identifiable, Codable {
  var id: String?
  let title: String
  let description: String
  let location: String
  let date: Date
  let type: String
  let postedBy: String
  let postedByEmail: String
}
