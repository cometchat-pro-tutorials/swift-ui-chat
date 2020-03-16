//
//  AvatarView.swift
//  CometChat
//
//  Created by Marin Benčević on 18/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
  
  let url: URL?
  let isOnline: Bool
  
  init(url: URL?, isOnline: Bool) {
    self.url = url
    self.isOnline = isOnline
    showsOnlineStatus = true
  }
  
  init(url: URL?) {
    self.url = url
    self.isOnline = false
    showsOnlineStatus = false
  }
  
  private let showsOnlineStatus: Bool
  
  private let placeholderName: String = {
    let name = "avatar_placeholder"
    let id = (0...4).randomElement()!
    return "\(name)\(id)"
  }()
  
  var body: some View {
    ZStack {
      Image("avatar_placeholder0")
        .resizable()
        .frame(width: 37, height: 37)
      
      if showsOnlineStatus {
        Circle()
          .frame(width: 10, height: 10)
          .foregroundColor(isOnline ? .green : .gray)
          .padding([.leading, .top], 25)
      }
    }
  }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: nil, isOnline: true)
          .previewLayout(.fixed(width: 100, height: 100))
    }
}
