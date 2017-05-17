//
//  Router.swift
//  BIY
//
//  Created by Ted Lythgoe on 08/05/2017.
//  Copyright © 2017 biyonline. All rights reserved.
//

import Foundation
import Alamofire

struct Router {
  static let baseUrlString = "https://biy.dreamrserve.uk/api/v1"
}

protocol RouterConvertible: URLRequestConvertible {
  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: Parameters? { get }
}

extension RouterConvertible {
  func asURLRequest() throws -> URLRequest {
    let url = try Router.baseUrlString.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    if let token = KeychainService().token() {
     urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    return urlRequest
  }
}
