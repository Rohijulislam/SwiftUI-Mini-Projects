//
//  HelloWorldAPI.swift
//  Hello-World
//
//  Created by Md. Rohejul Islam on 9/28/24.
//

import Foundation

class HelloWorldAPI: NetworkManager {
    
    // Override the URL method to provide the specific URL for this API
    override func requestURL() -> String? {
        return "https://raw.githubusercontent.com/Rohijulislam/SwiftUI-Mini-Projects/main/Nec%20files/hello.json"
    }
    
    // Override the HTTP method (default is GET, so this is not strictly necessary here)
    override func requestMethod() -> HTTPMethod {
        return .GET
    }
    
    // Fetch "Hello World" data from the API
    func fetchHelloWorld() async throws -> HelloWorld {
        return try await performRequest()
    }
    
    override func requestBody() -> Data? {
        return nil
    }
    
    override func requestHeaders() -> [String : String]? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    override func requestTimeoutInterval() -> TimeInterval {
        return 30.0 // Custom timeout of 15 seconds for this API
    }
    
    override func requestCachePolicy() -> URLRequest.CachePolicy {
        return .returnCacheDataElseLoad // Use cached data if available, else make network request
    }
}
