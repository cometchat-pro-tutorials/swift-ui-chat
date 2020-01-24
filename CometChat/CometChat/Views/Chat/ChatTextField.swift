//
//  ChatTextField.swift
//  CometChat
//
//  Created by Marin Benčević on 20/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI

struct ChatTextField: View {
  
  let sendAction: (String) -> Void
  
  @State private var messageText = ""
  
  var body: some View {
    VStack(spacing: 0) {
      Rectangle()
        .frame(height: 1)
        .foregroundColor(.white)
        .shadow(color: .shadow, radius: 3, x: 0, y: -2)
      
      HStack {
        TextField("Type something", text: $messageText)
          .frame(height: 60)
        
        Button(action: sendButtonTapped) {
          Image("send_message")
            .resizable()
            .frame(width: 25, height: 25)
            .padding(.leading, 16)
        }
      }
      .padding([.leading, .trailing])
      .background(Color.white)
    }.frame(height: 60)
  }
  
  private func sendButtonTapped() {
    sendAction(messageText)
    messageText = ""
  }
}

struct ChatTextField_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      ChatTextField(sendAction: { _ in })
    }.previewLayout(.fixed(width: 300, height: 80))
  }
}
