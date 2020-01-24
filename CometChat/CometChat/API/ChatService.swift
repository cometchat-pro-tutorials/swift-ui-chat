//
//  ChatService.swift
//  CometChat
//
//  Created by Marin Benčević on 03/01/2020.
//  Copyright © 2020 marinbenc. All rights reserved.
//

import Foundation
import Combine
import CometChatPro

extension String: Error {}

final class ChatService: ObservableObject {
  
  private enum Constants {
    #warning("Don't forget to set your API key and app ID here!")
    static let cometChatAPIKey = "API_KEY"
    static let cometChatAppID = "APP_ID"
  }
  
  static func initialize() {
    let settings = AppSettings.AppSettingsBuilder()
      .subscribePresenceForAllUsers()
      .setRegion(region: "eu")
      .build()
    
    _ = CometChat(
      appId: Constants.cometChatAppID,
      appSettings: settings,
      onSuccess: { isSuccess in
        print("CometChat connected successfully: \(isSuccess)")
      }, onError: { error in
        print(error)
      })
  }
  
  private var user: Contact?
  
  private let receivedMessageSubject = PassthroughSubject<Message, Never>()
  private let userStatusChangedSubject = PassthroughSubject<Contact, Never>()
  
  let receivedMessage: AnyPublisher<Message, Never>
  let userStatusChanged: AnyPublisher<Contact, Never>
  
  init() {
    receivedMessage = receivedMessageSubject.eraseToAnyPublisher()
    userStatusChanged = userStatusChangedSubject.eraseToAnyPublisher()
  }
  
  func login(email: String) -> Future<Contact, Error> {
    CometChat.messagedelegate = self
    CometChat.userdelegate = self
    
    return Future<Contact, Error> { promise in
      CometChat.login(
        UID: email,
        apiKey: Constants.cometChatAPIKey,
        onSuccess: { [weak self] cometChatUser in
          guard let self = self else { return }
          self.user = Contact(cometChatUser)
          DispatchQueue.main.async {
            promise(.success(self.user!))
          }
        },
        onError: { error in
          print("Error logging in:")
          print(error.errorDescription)
          DispatchQueue.main.async {
            promise(.failure("Error logging in"))
          }
        })
    }
  }
  
  func send(message: String, to reciever: Contact) {
    guard let user = user else {
      return
    }
    
    let textMessage = TextMessage(
      receiverUid: reciever.id,
      text: message,
      receiverType: .user)
    
    CometChat.sendTextMessage(
      message: textMessage,
      onSuccess: { [weak self] sentMessage in
        guard let self = self else { return }
        print("Message sent")
        DispatchQueue.main.async {
          self.receivedMessageSubject.send(Message(
            id: sentMessage.id,
            text: message,
            contact: user))
        }
      },
      onError: { error in
        print("Error sending message:")
        print(error?.errorDescription ?? "")
    })
  }
  
  private var usersRequest: UsersRequest?
  func getUsers() -> Future<[Contact], Error> {
    usersRequest = UsersRequest.UsersRequestBuilder().build()
    
    return Future<[Contact], Error> { promise in
      self.usersRequest?.fetchNext(
        onSuccess: { cometChatUsers in
          let users = cometChatUsers.map(Contact.init)
          DispatchQueue.main.async {
            promise(.success(users))
          }
        },
        onError: { error in
          let message = error?.errorDescription ?? "unknown"
          promise(.failure(message))
          print("Fetching users failed with error:")
          print(message)
        })
    }
  }
  
  private var messagesRequest: MessagesRequest?
  func getMessages(from sender: Contact) -> Future<[Message], Error> {
    let limit = 50
    
    messagesRequest = MessagesRequest.MessageRequestBuilder()
      .set(limit: limit)
      .set(uid: sender.id)
      .build()
    
    return Future<[Message], Error> { promise in
      self.messagesRequest!.fetchPrevious(
        onSuccess: { fetchedMessages in
          print("Fetched \(fetchedMessages?.count ?? 0) older messages")
          let messages = (fetchedMessages ?? [])
            .compactMap(Message.init)
          
          DispatchQueue.main.async {
            promise(.success(messages))
          }
        },
        onError: { error in
          let message = error?.errorDescription ?? "unknown"
          print("Fetching messages failed with error:")
          print(message)
          promise(.failure(message))
        })
    }
  }
}

extension ChatService: CometChatMessageDelegate {
  func onTextMessageReceived(textMessage: TextMessage) {
    DispatchQueue.main.async {
      guard let message = Message(textMessage) else {
        return
      }
      
      self.receivedMessageSubject.send(message)
    }
  }
}

extension ChatService: CometChatUserDelegate {
  
  func onUserOnline(user cometChatUser: CometChatPro.User) {
    DispatchQueue.main.async {
      self.userStatusChangedSubject.send(Contact(cometChatUser))
    }
  }
  
  func onUserOffline(user cometChatUser: CometChatPro.User) {
    DispatchQueue.main.async {
      self.userStatusChangedSubject.send(Contact(cometChatUser))
    }
  }
}
