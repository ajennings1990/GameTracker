//
//  Serializers.swift
//  Alamofire-Dreamr
//
//  Created by Andrea Perizzato on 04/05/2017.
//  Copyright © 2017 Dreamr. All rights reserved.
//

import Alamofire
import SwiftyJSON

/// A generic protocol defining a response from the server.
/// This protocol is then used to write generic
/// serializers for any type that conforms to it.
protocol ResponseWrapper {
  associatedtype Data

  var success: Bool { get }
  var data: Data? { get }
  var message: String? { get }
}

extension ObjectResponse: ResponseWrapper {}
extension EmptyResponse: ResponseWrapper {
  var data: Void? { return () }
}
extension ArrayResponse: ResponseWrapper {
  var data: PaginatedArray<T>? { return array }
}

struct SerializationProvider {

  /// Generic serializers for any type that conforms to ResponseWrapper
  /// whose Data is Decodable.
  ///
  /// - Parameters:
  ///   - request: original request
  ///   - response: http response
  ///   - data: response data
  ///   - error: network error
  ///   - ResponseWrapper: the desire type of response
  /// - Returns: deserialized data
  /// - Throws: APIError when something goes wrong.
  private static func serialize<Wrapper, Data>(
                            request: URLRequest?,
                            response: HTTPURLResponse?,
                            data: Foundation.Data?,
                            error: Error?,
                            wrapperType: Wrapper.Type) throws -> Data where
    Wrapper: Decodable & ResponseWrapper,
    Wrapper.Data == Data {

    // Make sure the HTTP request was successful
    guard error == nil else {
      throw APIError.network(error: error!)
    }

    // Try to parse the body
    let jsonSerializer = DataRequest.jsonResponseSerializer()
    let result = jsonSerializer.serializeResponse(request, response, data, error)
    guard case let .success(anyJSON) = result else {
      throw APIError.jsonSerialization(error: result.error!)
    }

    // Make sure the json is an object (not an array, etc)
    guard let json = anyJSON as? [String: AnyObject] else {
      throw APIError.invalidResponse
    }

    // Parse the json into a response
    guard let resultData = Wrapper(json: JSON(json)) else {
      throw APIError.invalidResponse
    }

    switch (resultData.success, resultData.data) {
    case (false, _):
      throw APIError.notSuccess(message: resultData.message)

    case (true, nil):
      throw APIError.invalidResponse

    case (true, .some(let data)):
      return data
    }
  }

  /// - Parameter wrapperType: the type wrapping the response.
  /// - Returns: a DataResponseSerializer for the given wrapper type.
  static func serializer<Wrapper, Data>(for wrapperType: Wrapper.Type)
    -> DataResponseSerializer<Data> where Wrapper: Decodable & ResponseWrapper,
                                          Wrapper.Data == Data {

    return DataResponseSerializer { request, response, data, error in
      do {
        let result = try serialize(request: request,
                                   response: response,
                                   data: data,
                                   error: error,
                                   wrapperType: wrapperType)
        return .success(result)
      } catch let error {
        return .failure(error)
      }
    }
  }
}
