//
//  ContentView.swift
//  SwiftUIPhotoMetadata
//
//  Created by Developer on 23.12.2021.
//

import SwiftUI

struct ContentView: View {
  @StateObject var photos = Remote(url: URL(string: "https://picsum.photos/v2/list")!, transform: { data in
    try? JSONDecoder().decode([Photo].self, from: data)
  })
  var body: some View {
    if photos.value == nil {
      Text("Loading...")
        .onAppear { photos.load() }
    }
    else {
      if let photos = photos.value {
        NavigationView {
          List {
            ForEach(photos) { photo in
              NavigationLink(destination: PhotoView(url: photo.downloadURL)) {
                PhotoCell(authorName: photo.author)
              }
            }
          }
        }
      } else {
        Text("Empty.")
      }
    }
  }
}

struct PhotoCell: View {
  let authorName: String
  var body: some View {
    Text("Author: \(authorName)")
  }
}

struct PhotoView: View {
  @ObservedObject var image: Remote<UIImage>
  init(url: URL) {
    image = Remote(url: url, transform: { data in
      UIImage(data: data)
    })
  }
  var body: some View {
    if image.value == nil {
      Text("Loading...")
        .onAppear { image.load() }
    }
    else {
      if let image = image.value {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(image.size, contentMode: .fit)
        
      } else {
        Text("Empty.")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
