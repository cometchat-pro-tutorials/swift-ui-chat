//
//  LoginView.swift
//  CometChat
//
//  Created by Marin Benčević on 05/11/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
  
  @EnvironmentObject private var store: AppStore
  @EnvironmentObject private var chatService: ChatService

  @State private var email = ""
  @State private var showContacts = false
  
  @State private var subscriptions: Set<AnyCancellable> = []
  
  var body: some View {
    VStack(alignment: .leading, spacing: 26) {
      Text("Log In")
        .modifier(TitleText())
      
      ErrorTextField(
        title: "Email",
        placeholder: "mail@example.com",
        iconName: "email",
        text: $email,
        keyboardType: .emailAddress,
        isValid: isValid)
      
      Spacer()
      
      Button(action: login) {
        PrimaryButton(title: "Log In")
      }
      
      NavigationLink(destination: ContactsView(), isActive: $showContacts) {
        EmptyView()
      }
    }
    .padding()
  }
  
  func login() {
    store.state.chatService.login(email: email)
      .sink(receiveCompletion: { error in
        print(error)
      }, receiveValue: { user in
        self.store.setCurrentUser(user)
        self.showContacts = true
      })
      .store(in: &subscriptions)
  }
  
  func isValid(email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
    return predicate.evaluate(with: email)
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
