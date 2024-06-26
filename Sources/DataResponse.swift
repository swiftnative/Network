//
// Created by Alexey Nenastyev on 8.6.24.
// Copyright © 2023 Alexey Nenastyev (github.com/alexejn). All Rights Reserved.


import Foundation
import HTTPTypes

/// Response with data
public struct DataResponse {
  /// URLRequest
  public let request: URLRequest
  /// HTTP Status of response
  public let status: HTTPResponse.Status
  /// Response headers
  public let headerFields: HTTPFields
  /// Response data
  public let data: Data

  public init(request: URLRequest, response: HTTPResponse, data: Data) {
    self.request = request
    self.status = response.status
    self.headerFields = response.headerFields
    self.data = data
  }

  public struct Config {
    public var decoder: JSONDecoder = defaultDecoder
    public static var defaultDecoder = JSONDecoder()

    public init () {}
  }

  public func decode<T: Decodable>(
    _ config: Config = .init(),
    _ type: T.Type = T.self) throws -> T {
      try config.decoder.decode(type, from: data)
  }

  public func decode<T: Decodable>(
    decoder: JSONDecoder,
    _ type: T.Type = T.self
  ) throws -> T {
    try decoder.decode(type, from: data)
  }

  public var bodyString: String { data.json ?? "" }
}

extension DataResponse: Error {

}
