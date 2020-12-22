//
//  File.swift
//
//  Created by Aya Essam on 12/7/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct File: Codable {

  enum CodingKeys: String, CodingKey {
    case path
    case id
    case createdAt = "created_at"
  }

  var path: String?
  var id: String?
  var createdAt: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    path = try container.decodeIfPresent(String.self, forKey: .path)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    createdAt = try container.decodeIfPresent(Int.self, forKey: .createdAt)
  }

}
