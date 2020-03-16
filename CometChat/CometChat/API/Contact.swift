//
//  Contact.swift
//  CometChat
//
//  Created by Marin Benčević on 09/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import Foundation
import CometChatPro

struct Contact: Identifiable, Equatable {
  let name: String
  let avatar: URL?
  let id: String
  var isOnline: Bool
}

extension Contact {
  init(_ cometChatUser: User) {
    self.id = cometChatUser.uid ?? "unknown"
    self.name = cometChatUser.name ?? "unknown"
    self.avatar = cometChatUser.avatar.flatMap(URL.init)
    self.isOnline = cometChatUser.status == .online
  }
}
