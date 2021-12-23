//
//  APIClient.swift
//  SwiftUIPhotoMetadata
//
//  Created by Developer on 23.12.2021.
//

import Foundation
import SwiftUI

struct UnknownError: Error {}

final class APIClient {
  func fetch<T>(url: URL, transform: @escaping (Data) -> T?, completionHandler: @escaping (Result<T, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completionHandler(.failure(error))
        return
      }
      guard let data = data,
            let transformedData = transform(data) else {
        completionHandler(.failure(UnknownError()))
        return
      }
      completionHandler(.success(transformedData))
    }.resume()
  }
}
