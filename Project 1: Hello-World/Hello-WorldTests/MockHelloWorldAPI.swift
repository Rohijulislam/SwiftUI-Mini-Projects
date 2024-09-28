//
//  MockHelloWorldAPI.swift
//  Hello-WorldTests
//
//  Created by Md. Rohejul Islam on 9/28/24.
//

import Foundation

class MockHelloWorldAPI: HelloWorldAPI {
    var shouldReturnError = false
    
    override func fetchHelloWorld() async throws -> HelloWorld {
        if shouldReturnError {
            throw NetworkError.invalidResponse
        }
        if let mockData = mockData() {
            return mockData
        } else {
            throw NetworkError.decodingError
        }
    }
    
    
    private func mockData() -> HelloWorld? {
        return HelloWorld(message: "Hello, World!")
    }
}
