//
//  ObjectResponse.swift
//  Alamofire-Dreamr
//
//  Created by Andrea Perizzato on 04/05/2017.
//  Copyright © 2017 Dreamr. All rights reserved.
//

import SwiftyJSON

/// Object representing an object response from the server
struct ObjectResponse<T: Decodable>: Decodable {

  /// Whether the response was successful or not
  let success: Bool
  /// The error message, if any
  let message: String?
  /// The actual object
  let data: T?

  init?(json: JSON) {
    success = json[Key.result][Key.Result.success].boolValue
    message = json[Key.result][Key.Result.message].string
    data = T(json: json[Key.payload][Key.Payload.data])
  }
}
