//
//  AppDelegate.swift
//  GameTracker
//
//  Created by Andrew Jennings on 17/05/2017.
//  Copyright © 2017 aj. All rights reserved.
//


import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // init window
    window = UIWindow(frame: UIScreen.main.bounds)
    
    // when testing show a simple view controller without loading the actual app
    if NSClassFromString("XCTest") != nil {
      window!.rootViewController = UIViewController()
      window!.makeKeyAndVisible()
      return true
    }
    
    let rootViewController = UIViewController()
    
    if KeychainService().token() != nil {
//      rootViewController = TabBarController()
    } else {
//      rootViewController = OpeningViewController()
    }
    
    window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    window?.makeKeyAndVisible()
    
    // framework configuration
    Fabric.with([Crashlytics.self])
    
    return true
  }
}

