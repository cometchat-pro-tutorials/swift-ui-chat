//
//  Store.swift
//  CometChat
//
//  Created by Marin Benčević on 20/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI

class AppStore: ObservableObject {
  
  struct AppState {
    var currentUser: Contact?
    let chatService: ChatService
  }
  
  @Published private(set) var state = AppState(currentUser: nil, chatService: ChatService())
  
  func setCurrentUser(_ user: Contact?) {
    state.currentUser = user
  }
  
}
