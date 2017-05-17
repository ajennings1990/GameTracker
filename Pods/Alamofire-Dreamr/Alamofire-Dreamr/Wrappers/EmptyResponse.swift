//
//  EmptyResponse.swift
//  Alamofire-Dreamr
//
//  Created by Andrea Perizzato on 04/05/2017.
//  Copyright © 2017 Dreamr. All rights reserved.
//
import SwiftyJSON

/// A value representing an empty response.
struct EmptyResponse: Decodable {

  /// Whether the request was successful or not
  let success: Bool
  /// The error message, if any
  let message: String?

  init?(json: JSON) {
    success = json[Key.result][Key.Result.success].boolValue
    message = json[Key.result][Key.Result.message].string
  }
}
