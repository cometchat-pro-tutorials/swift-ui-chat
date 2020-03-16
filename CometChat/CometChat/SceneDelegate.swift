//
//  SceneDelegate.swift
//  CometChat
//
//  Created by Marin Benčević on 04/11/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  let store = AppStore()
  let chatService = ChatService()

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

    ChatService.initialize()
    
    // Create the SwiftUI view that provides the window contents.
    let contentView: some View = NavigationView {
      WelcomeView()
    }
    .environmentObject(store)

    // Use a UIHostingController as window root view controller.
    if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
    }
  }


}

