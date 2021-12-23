//
//  Remote.swift
//  SwiftUIPhotoMetadata
//
//  Created by Developer on 23.12.2021.
//

import Foundation

class Remote<T>: ObservableObject {
  @Published var result: Result<T, Error>? = nil
  var value: T? { try? result?.get() }
  
  let url: URL
  let transform: (Data) -> T?
  
  private let apiClient = APIClient()
  
  init(url: URL, transform: @escaping (Data) -> T?) {
    self.url = url
    self.transform = transform
  }
  
  func load() {
    apiClient.fetch(url: url, transform: transform) { result in
      switch result {
      case .success(let data):
        self.result = .success(data)
      case .failure(let error):
        self.result = .failure(error)
      }
    }
  }
}
