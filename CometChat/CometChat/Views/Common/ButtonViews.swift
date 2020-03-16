//
//  ButtonViews.swift
//  CometChat
//
//  Created by Marin Benčević on 04/11/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI

struct PrimaryButton: View {
  
  let title: String
  
  var body: some View {
    Text(title.uppercased())
      .fontWeight(.bold)
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.accentColor)
      .cornerRadius(5)
      .shadow(color: .shadow, radius: 15, x: 0, y: 5)
  }
}


struct _PrimaryButton: View {
  
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title.uppercased())
        .fontWeight(.bold)
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
    }
    .background(Color.accentColor)
    .cornerRadius(5)
    .shadow(
      color: Color(red: 27 / 255, green: 71 / 255, blue: 219 / 255, opacity: 0.3),
      radius: 15, x: 0, y: 5)
  }
}

struct SecondaryButton: View {
  
  let title: String
  
  var body: some View {
    Text(title.uppercased())
      .fontWeight(.bold)
      .foregroundColor(.accentColor)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.white)
      .cornerRadius(5)
      .shadow(color: .shadow, radius: 15, x: 0, y: 5)
  }
}

struct Button_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      PrimaryButton(title: "Primary")
        .previewLayout(.fixed(width: 300, height: 100))
      SecondaryButton(title: "Secondary")
        .previewLayout(.fixed(width: 300, height: 100))
    }
  }
}
