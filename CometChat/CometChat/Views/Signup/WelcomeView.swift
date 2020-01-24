//
//  WelcomeView.swift
//  CometChat
//
//  Created by Marin Benčević on 04/11/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
  
  private enum PresentedView {
    case login
    case register
  }
  
  @State private var presentedView: PresentedView?
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Connect with people around the world")
        .modifier(TitleText())
        .padding([.bottom, .leading, .trailing])
      
      VStack(alignment: .center) {
        Image("welcome")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(.bottom, 35)
          .padding([.leading, .trailing], 80)
      
        Text("""
          This is a sample app.
          Create an account or login to begin chatting.
          """)
          .modifier(BodyText())
          .multilineTextAlignment(.center)
          .padding([.leading, .trailing], 40)
      }
      
      VStack(spacing: 30) {
        NavigationLink(destination: LoginView()) {
          PrimaryButton(title: "Log In")
        }
      
        NavigationLink(destination: EmptyView()) {
          SecondaryButton(title: "Sign Up")
        }
      }
      .padding([.leading, .bottom, .trailing])
      .padding(.top, 40)
      
      Spacer()
    }
    .navigationBarTitle("Create an account")
  }
  
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NavigationView {
        WelcomeView()
          .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
      }
    }
  }
}
