//
//  Decodable.swift
//  Alamofire-Dreamr
//
//  Created by Andrea Perizzato on 04/05/2017.
//  Copyright © 2017 Dreamr. All rights reserved.
//

import SwiftyJSON

/// Anything that can be decoded from a SwiftyJSON.JSON object
public protocol Decodable {
    init?(json: JSON)
}
