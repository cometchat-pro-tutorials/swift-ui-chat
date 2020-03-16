//
//  ContactItemView.swift
//  CometChat
//
//  Created by Marin Benčević on 09/12/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI

struct ContactRow: View {
  
  struct ContactItem: Identifiable {
    let contact: Contact
    let lastMessage: String
    let unread: Bool
    
    var id: String { contact.id }
  }
  
  let item: ContactItem
  
  var body: some View {
    VStack {
      Spacer()

      HStack {
        AvatarView(url: nil, isOnline: item.contact.isOnline)
            .padding(.leading, 20)
                
        VStack(alignment: .leading) {
          Text(item.contact.name)
            .foregroundColor(.body)
            .fontWeight(item.unread ? .medium : .regular)
            .lineLimit(1)

          Text(item.lastMessage)
            .foregroundColor(.body)
            .font(.system(size: 12))
            .fontWeight(item.unread ? .medium : .regular)
            .lineLimit(1)
            .padding(.top, 2)
        }
        .padding(.leading, 10)
        .padding(.trailing, 20)
        
        Spacer()
      }
      
      Spacer()
      
      Rectangle()
        .frame(height: 1)
        .foregroundColor(Color(UIColor.separator))
    }
    .background(item.unread ? Color.background : nil)
    .frame(maxWidth: .infinity)
    .frame(height: 67)
  }

}

struct ContactRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContactRow(item: ContactRow.ContactItem(
        contact: Contact(name: "Some Name", avatar: nil, id: "0", isOnline: true),
        lastMessage: "Last message is a pretty big message",
        unread: true))
        .previewLayout(.fixed(width: 300, height: 67))
      ContactRow(item: ContactRow.ContactItem(
        contact: Contact(name: "Other Name", avatar: nil, id: "1", isOnline: false),
        lastMessage: "Last message is a pretty big message",
        unread: false))
        .previewLayout(.fixed(width: 300, height: 67))
    }
  }
}
