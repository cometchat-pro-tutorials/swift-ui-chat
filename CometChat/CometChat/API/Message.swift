//
//  Message.swift
//  CometChat
//
//  Created by Marin Benčević on 18/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import Foundation
import CometChatPro

struct Message: Identifiable {
  let id: Int
  let text: String
  let contact: Contact
}

extension Message {
  init?(_ message: CometChatPro.BaseMessage) {
    guard let message = message as? TextMessage,
      let sender = message.sender else {
      return nil
    }
    
    self.id = message.id
    self.text = message.text
    self.contact = Contact(sender)
  }
}
