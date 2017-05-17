//
//  Key.swift
//  Alamofire-Dreamr
//
//  Created by Andrea Perizzato on 04/05/2017.
//  Copyright © 2017 Dreamr. All rights reserved.
//

struct Key {

  static let result = "result"
  struct Result {
    /// Boolean success state
    static let success = "success"
    /// The error message
    static let message = "message"
  }

  static let payload = "response_payload"
  struct Payload {
    /// The key to get the data
    static let data = "data"
    /// The total number of items
    static let total = "total"
    /// The url to get the next page
    static let nextURL = "next_page_url"
    /// The number of the current page
    static let currentPage = "current_page"
    /// The number of the last page
    static let lastPage = "last_page"
  }
}
