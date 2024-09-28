//
//  APIRequestProtocol.swift
//  Hello-World
//
//  Created by Md. Rohejul Islam on 9/28/24.
//

import Foundation

// Protocol that defines the required methods
protocol APIRequestProtocol: AnyObject {
    func requestURL() -> String?
    func requestMethod() -> HTTPMethod
    func requestHeaders() -> [String: String]?
    func requestBody() -> Data?
    func requestCachePolicy() -> URLRequest.CachePolicy
    func requestTimeoutInterval() -> TimeInterval
}
