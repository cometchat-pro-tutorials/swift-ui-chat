//
//  TextModifiers.swift
//  CometChat
//
//  Created by Marin Benčević on 05/11/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI

struct TitleText: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(Font.largeTitle.weight(.bold))
      .foregroundColor(.cometChatBlue)
  }
}

struct BodyText: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.body)
  }
}
