//
//  ChatView.swift
//  CometChat
//
//  Created by Marin Benčević on 18/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI
import Combine

struct ChatView: View {
  
  let currentUser: Contact
  let receiver: Contact
     
  init(currentUser: Contact, receiver: Contact) {
    self.currentUser = currentUser
    self.receiver = receiver
    
    UITableView.appearance().tableFooterView = UIView()
    UITableView.appearance().separatorStyle = .none
    UITableView.appearance().backgroundColor = .clear
    UITableViewCell.appearance().backgroundColor = .clear
  }
  
  @ObservedObject private var keyboardObserver = KeyboardObserver()
  @EnvironmentObject private var store: AppStore
  
  @State private var messages: [Message] = []
  @State private var subscriptions: Set<AnyCancellable> = []
  
  private func isMessageLastFromContact(at index: Int) -> Bool {
    let message = messages[index]
    let next = index < messages.count - 1 ? messages[index + 1] : nil
    return message.contact != next?.contact
  }
  
  var body: some View {
    ZStack {
      Color.background.edgesIgnoringSafeArea(.top)
      
      VStack {
        List {
          ForEach(0..<messages.count, id: \.self) { i in
            ChatMessageRow(
              message: self.messages[i],
              isIncoming: self.messages[i].contact.id != self.currentUser.id,
              isLastFromContact: self.isMessageLastFromContact(at: i))
              .listRowInsets(EdgeInsets(
                top: i == 0 ? 16 : 0,
                leading: 12,
                bottom: self.isMessageLastFromContact(at: i) ? 20 : 6,
                trailing: 12))
          }
        }
        
        ChatTextField(sendAction: onSendTapped)
          .padding(.bottom, keyboardObserver.keyboardHeight)
          .animation(.easeInOut(duration: 0.3))
      }
    }
    .navigationBarTitle(Text(receiver.name), displayMode: .inline)
    .onAppear(perform: getMessages)
    .onAppear(perform: updateMessagesOnChange)
  }
  
  private func getMessages() {
    store.state.chatService.getMessages(from: receiver)
      .sink(receiveCompletion: { error in
        print(error)
      }, receiveValue: { messages in
        self.messages = messages
      })
      .store(in: &subscriptions)
  }
  
  private func updateMessagesOnChange() {
    store.state.chatService.receivedMessage.sink { message in
      guard message.contact.id == self.receiver.id ||
        message.contact.id == self.currentUser.id else {
        return
      }
      
      self.messages.append(message)
    }.store(in: &subscriptions)
  }
  
  private func onSendTapped(message: String) {
    store.state.chatService.send(message: message, to: receiver)
  }
}

struct ChatView_Previews: PreviewProvider {
  static var previews: some View {
    ChatView(
      currentUser: Contact(name: "Me", avatar: nil, id: "me", isOnline: true),
      receiver: Contact(name: "Other", avatar: nil, id: "other", isOnline: true)
    )
  }
}
