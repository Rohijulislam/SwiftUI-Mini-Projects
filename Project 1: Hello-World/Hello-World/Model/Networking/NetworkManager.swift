//
//  NetworkManager.swift
//  Hello-World
//
//  Created by Md. Rohejul Islam on 9/28/24.
//

import Foundation

/// Define Network Errors
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case unknownError
    
    var errorDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid Response"
        case .decodingError: return "Error decoding data"
        case .unknownError: return "Unknown Error"
        }
    }
}

// HTTP Methods
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}


class NetworkManager: APIRequestProtocol {
    
    // Generic method to perform network requests
    func performRequest<T: Codable>() async throws -> T {
        
        guard let urlString = requestURL(), let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.requestMethod().rawValue
        request.timeoutInterval = requestTimeoutInterval() // Set the timeout interval
        request.cachePolicy = requestCachePolicy() // Set the cache policy
        
        if let headers = requestHeaders() {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = requestBody() {
            request.httpBody = body
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Print raw response data for debugging
        if let rawDataString = String(data: data, encoding: .utf8) {
            print("Raw Data: \(rawDataString)")
        } else {
            print("Unable to decode raw data into string.")
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // Conform to protocol (default behavior, can be overridden by subclass)
    func requestURL() -> String? { return nil }
    func requestMethod() -> HTTPMethod { return .GET }
    func requestTimeoutInterval() -> TimeInterval { return 30.0 } // Default timeout interval of 30 seconds
    func requestCachePolicy() -> URLRequest.CachePolicy { return .returnCacheDataElseLoad }
    func requestHeaders() -> [String : String]? { return nil }
    func requestBody() -> Data? { return nil }
}
