//
//  ArrayResponse.swift
//  Alamofire-Dreamr
//
//  Created by Andrea Perizzato on 04/05/2017.
//  Copyright © 2017 Dreamr. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Information about paginated data
public struct PaginationInfo: Decodable {
  /// The total number of elements, regardless pagination
  public let total: Int
  /// The URL to get the next page, if any
  public let nextURL: URL?
  /// Whether this is the last page or not
  public let isLastPage: Bool

  init(total: Int, nextURL: URL?, isLastPage: Bool) {
    self.total = total
    self.nextURL = nextURL
    self.isLastPage = isLastPage
  }

  public init?(json: JSON) {
    total = json[Key.Payload.total].int ?? 0
    nextURL = json[Key.Payload.nextURL].url

    let thisPage = json[Key.Payload.currentPage].int ?? 0
    let lastPage = json[Key.Payload.lastPage].int ?? 0
    isLastPage = thisPage >= lastPage
  }
}

/// An array of containing pagination info
public struct PaginatedArray<T> {
  /// Information about pagination. 
  /// `nil` when the paga is not paginated
  public let info: PaginationInfo?
  /// The data of the current page
  public let data: [T]

  public init(data: [T], info: PaginationInfo? = nil) {
    self.info = info
    self.data = data
  }

  /// Maps the page data using the given transformation.
  /// The pagination info will be the same as the receiver.
  ///
  /// - Parameter transform: tranform to apply to each element
  /// - Returns: mapped paginated array.
  public func map<U>(_ transform: (T) -> U) -> PaginatedArray<U> {
    let mapped = data.map(transform)
    return PaginatedArray<U>(data: mapped, info: info)
  }
}

/// Object representing an array response from the server
struct ArrayResponse<T: Decodable>: Decodable {
  let success: Bool
  let message: String?
  let array: PaginatedArray<T>

  init?(json: JSON) {
    guard
      let success = json[Key.result][Key.Result.success].bool,
      let dataJson: [JSON] = json[Key.payload][Key.Payload.data].array
    else {
        return nil
    }

    let info = PaginationInfo(json: json[Key.payload])
    let data = dataJson.flatMap(T.init(json:))

    self.success = success
    message = json[Key.result][Key.Result.message].string
    array = PaginatedArray(data: data, info: info)
  }
}
