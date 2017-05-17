//
//  DataRequest+Serializers.swift
//  Alamofire-Dreamr
//
//  Created by Andrea Perizzato on 04/05/2017.
//  Copyright © 2017 Dreamr. All rights reserved.
//

import Alamofire

public typealias DataResponseHandler<T> = (DataResponse<T>) -> Void
public typealias ArrayResponseHandler<T> = (DataResponse<PaginatedArray<T>>) -> Void

extension DataRequest {

  @discardableResult
  public func responseObject<T: Decodable>(
                             _ type: T.Type,
                             queue: DispatchQueue? = nil,
                             completion: @escaping DataResponseHandler<T>) -> Self {

    let serializer = SerializationProvider.serializer(for: ObjectResponse<T>.self)
    return response(queue: queue,
                    responseSerializer: serializer,
                    completionHandler: completion)
  }

  @discardableResult
  public func responseArray<T: Decodable>(
                            _ type: T.Type,
                            queue: DispatchQueue? = nil,
                            completion: @escaping ArrayResponseHandler<T>) -> Self {

    let serializer = SerializationProvider.serializer(for: ArrayResponse<T>.self)
    return response(queue: queue,
                    responseSerializer: serializer,
                    completionHandler: completion)
  }

  @discardableResult
  public func responseEmpty(queue: DispatchQueue? = nil,
                            completion: @escaping DataResponseHandler<Void>) -> Self {

    let serializer = SerializationProvider.serializer(for: EmptyResponse.self)
    return response(queue: queue,
                    responseSerializer: serializer,
                    completionHandler: completion)
  }

}
