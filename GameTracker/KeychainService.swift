//
//  KeychainService.swift
//  BIY
//
//  Created by Ted Lythgoe on 11/05/2017.
//  Copyright © 2017 biyonline. All rights reserved.
//

import Foundation
import KeychainAccess
import SwiftyJSON

struct KeychainService {

  struct Key {
    static let user = "user"
    static let token = "token"
  }

  let keychain: Keychain

  init() {
    keychain = Keychain(server: Router.baseUrlString, protocolType: .https)
  }

//  func save(auth: Auth) {
//    save(token: auth.token)
//    save(authJson: auth.json)
//  }

  private func save(authJson: JSON) {
    //TODO: error handle rawString nil
    keychain[string: Key.user] = authJson.rawString()
  }

//  func user() -> User? {
//    guard let jsonString = keychain[string: Key.user] else {
//      return nil
//    }
//    return User(json: JSON(parseJSON: jsonString))
//  }

  func removeUser() -> Bool {
    do {
      try keychain.remove(Key.user)
      return true
    } catch let error {
      print("\(#function) - error: \(error)")
      return false
    }
  }

  func save(token: String) {
    keychain[string: Key.token] = token
  }

  func token() -> String? {
    return keychain[string: Key.token]
  }

  func removeToken() -> Bool {
    do {
      try keychain.remove(Key.token)
      return true
    } catch let error {
      print("\(#function) - error: \(error)")
      return false
    }
  }
}
