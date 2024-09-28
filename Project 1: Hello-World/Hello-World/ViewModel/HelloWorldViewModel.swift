//
//  HelloWorldViewModel.swift
//  Hello-World
//
//  Created by Md. Rohejul Islam on 9/28/24.
//

import SwiftUI
@MainActor
class HelloWorldViewModel: ObservableObject {
    @Published var helloWorld: HelloWorld?
    @Published var errorMessage: String?
    @Published var currentColorIndex = 0
    @Published var scale: CGFloat = 1.0
    @Published var isAnimating = false
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .brown, .pink, .indigo]
    let animationInterval: TimeInterval = 5.0
    
    private let helloWorldAPI: HelloWorldAPI
    private var animationTimer: Timer?
    
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
    
    func startAnimations() {
        self.isAnimating = true
        let timer = Timer.scheduledTimer(withTimeInterval: animationInterval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.currentColorIndex = (self.currentColorIndex + 1) % self.colors.count
                withAnimation(.easeInOut(duration: self.animationInterval)) {
                    self.scale = self.scale == 1.0 ? 1.4 : 1.0
                }
            }
        }
        animationTimer = timer
        animationTimer?.fire()
    }
    
    deinit {
        animationTimer?.invalidate()
    }
}

