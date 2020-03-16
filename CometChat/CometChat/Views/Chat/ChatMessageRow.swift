//
//  ChatMessageRow.swift
//  CometChat
//
//  Created by Marin Benčević on 18/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI

struct ChatMessageRow: View {
  
  let message: Message
  let isIncoming: Bool
  let isLastFromContact: Bool
  
  private func chatBubbleTriange(width: CGFloat, height: CGFloat, isIncoming: Bool) -> some View {
    Path { path in
      path.move(to: CGPoint(x: isIncoming ? 0 : width, y: height * 0.5))
      path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: height))
      path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: 0))
      path.closeSubpath()
    }
    .fill(isIncoming ? Color.white : Color.cometChatBlue)
    .frame(width: width, height: height)
    .shadow(color: .shadow, radius: 2, x: 0, y: 1)
    .zIndex(10)
    .clipped()
    .padding(.trailing, isIncoming ? -1 : 10)
    .padding(.leading, isIncoming ? 10 : -1)
    .padding(.bottom, 12)
  }
  
  private var chatBubble: some View {
    RoundedRectangle(cornerRadius: 6)
      .foregroundColor(isIncoming ? .white : .cometChatBlue)
      .shadow(color: .shadow, radius: 2, x: 0, y: 1)
  }
  
  private var text: some View {
    Text(message.text)
      .padding(10)
      .foregroundColor(isIncoming ? .body : .white)
      .modifier(BodyText())
      .background(chatBubble)
  }
  
  var body: some View {
    HStack(alignment: .bottom, spacing: 0) {
      if isIncoming {
        if isLastFromContact {
          AvatarView(url: message.contact.avatar)
          chatBubbleTriange(width: 15, height: 14, isIncoming: true)
        } else {
          Spacer().frame(width: 61)
        }
        
        text
        
        Spacer()
      } else {
        Spacer()
        
        text
        
        if isLastFromContact {
          chatBubbleTriange(width: 15, height: 14, isIncoming: false)
          AvatarView(url: message.contact.avatar)
        } else {
          Spacer().frame(width: 61)
        }
      }
    }
  }
}

struct ChatMessageRow_Previews: PreviewProvider {
  
  private static let chatMessage = Message(
    id: UUID().hashValue,
    text: "Pellentesque ipsum. Mauris elem enes tumen mauris vitae tortor. Pellentesque ipsum.",
    contact: Contact(name: "Name", avatar: nil, id: "id", isOnline: true))
  
  static var previews: some View {
    Group {
      ChatMessageRow(
        message: chatMessage,
        isIncoming: true,
        isLastFromContact: true)
        .previewLayout(.fixed(width: 300, height: 200))
      
      ChatMessageRow(
        message: chatMessage,
        isIncoming: true,
        isLastFromContact: false)
        .previewLayout(.fixed(width: 300, height: 200))
      
      ChatMessageRow(
        message: chatMessage,
        isIncoming: false,
        isLastFromContact: true)
        .previewLayout(.fixed(width: 300, height: 200))
    }
  }
}
