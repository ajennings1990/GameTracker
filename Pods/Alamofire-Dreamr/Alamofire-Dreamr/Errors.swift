//
//  Errors.swift
//  Alamofire-Dreamr
//
//  Created by Andrea Perizzato on 04/05/2017.
//  Copyright © 2017 Dreamr. All rights reserved.
//

/// Errors thrown when making a request
public enum APIError: Error {
  /// Capture any underlying Error from the URLSession API
  case network(error: Error)
  /// The response could not be serialized
  case jsonSerialization(error: Error)
  /// The response is not valid. 
  /// The serialization was successful, but the format was not
  /// as expected.
  case invalidResponse
  /// The response was ok, but the `success` flag was set to `false`,
  /// denoting that something went wrong.
  case notSuccess(message: String?)
}
