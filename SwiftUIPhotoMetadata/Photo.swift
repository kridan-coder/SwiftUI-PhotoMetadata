//
//  Photo.swift
//  SwiftUIPhotoMetadata
//
//  Created by Developer on 23.12.2021.
//

import Foundation

struct Photo: Codable, Identifiable {
  enum CodingKeys: String, CodingKey {
    case id, author, width, height, url, downloadURL = "download_url"
  }
  
  let id: String
  let author: String
  let width: Int
  let height: Int
  let url: URL
  let downloadURL: URL
}
