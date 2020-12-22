//
//  Response.swift
//
//  Created by Aya Essam on 12/7/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Response: Codable {

  enum CodingKeys: String, CodingKey {
    case subjects = "data"
    case status
    case success
  }

  var subjects: [Subjects]?
  var status: Int?
  var success: Bool?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    subjects = try container.decodeIfPresent([Subjects].self, forKey: .subjects)
    status = try container.decodeIfPresent(Int.self, forKey: .status)
    success = try container.decodeIfPresent(Bool.self, forKey: .success)
  }

}
