//
//  Subjects.swift
//
//  Created by Aya Essam on 12/7/20
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Subjects: Codable {

  enum CodingKeys: String, CodingKey {
//    case interests
    case file
    case id
    case title
    case type
  }

//  var interests: Any?
  var file: File?
  var id: String?
  var title: String?
  var type: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
//    interests = try container.decodeIfPresent([].self, forKey: .interests)
    file = try container.decodeIfPresent(File.self, forKey: .file)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    type = try container.decodeIfPresent(Int.self, forKey: .type)
  }

}
