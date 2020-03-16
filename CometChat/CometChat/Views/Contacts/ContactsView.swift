//
//  ContactsView.swift
//  CometChat
//
//  Created by Marin Benčević on 09/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI
import Combine

struct ContactsView: View {
  
  @EnvironmentObject private var store: AppStore
  
  init() {
    UITableView.appearance().tableFooterView = UIView()
    UITableView.appearance().separatorStyle = .none
  }
  
  @State private var items: [Contact] = []
  @State private var subscriptions: Set<AnyCancellable> = []
  
  var body: some View {
    List {
      ForEach(0..<items.count, id: \.self) { i in
        ZStack {
          ContactRow(item: ContactRow.ContactItem(
            contact: self.items[i],
            lastMessage: "",
            unread: false))
          
          self.store.state.currentUser.map { currentUser in
            NavigationLink(destination: ChatView(
              currentUser: currentUser,
              receiver: self.items[i]
            )) {
              EmptyView()
            }
          }
        }
        .background(Color.white)
        .shadow(
          color: i == self.items.count - 1 ? Color(UIColor.black.withAlphaComponent(0.08)) : Color.clear,
          radius: 10, x: 0, y: 2)
        .listRowInsets(EdgeInsets())
      }
    }
    .navigationBarTitle("Contacts", displayMode: .inline)
    .onAppear(perform: getContacts)
    .onAppear(perform: updateContactsOnChange)
  }
  
  private func getContacts() {
    store.state.chatService.getUsers()
      .sink(receiveCompletion: { error in
        print(error)
      }, receiveValue: { contacts in
        self.items = contacts
      })
      .store(in: &subscriptions)
  }
  
  private func updateContactsOnChange() {
    store.state.chatService.userStatusChanged.sink { newContact in
      guard let index = self.items.firstIndex(where: { $0.id == newContact.id }) else {
        return
      }
      
      self.items[index] = newContact
    }.store(in: &subscriptions)
  }
}

struct ContactsView_Previews: PreviewProvider {
  static var previews: some View {
    ContactsView()
  }
}
