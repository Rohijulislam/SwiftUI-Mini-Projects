//
//  HelloWorldViewModel.swift
//  Hello-World
//
//  Created by Md. Rohejul Islam on 9/28/24.
//

import Foundation

@MainActor
class HelloWorldViewModel: ObservableObject {
    @Published var helloWorld: HelloWorld?
    @Published var errorMessage: String?
    
    private let helloWorldAPI: HelloWorldAPI
    
    init(helloWorldAPI: HelloWorldAPI = HelloWorldAPI()) {
        self.helloWorldAPI = helloWorldAPI
    }
    
    // Fetch "Hello World" data
    func fetchHelloWorld() {
        Task {
            do {
                let data = try await helloWorldAPI.fetchHelloWorld()
                self.helloWorld = data
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

