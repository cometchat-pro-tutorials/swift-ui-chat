//
//  AppDelegate.swift
//  CometChat
//
//  Created by Marin Benčević on 04/11/2019.
//  Copyright © 2019 marinbenc. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UINavigationBar.appearance().largeTitleTextAttributes = [
      .font: UIFont.systemFont(ofSize: 16),
      .foregroundColor: UIColor.body
    ]
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

}

