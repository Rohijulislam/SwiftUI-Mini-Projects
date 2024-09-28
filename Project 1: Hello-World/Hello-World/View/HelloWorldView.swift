//
//  HelloWorldView.swift
//  Hello-World
//
//  Created by Md. Rohejul Islam on 9/28/24.
//

import SwiftUI

struct HelloWorldView: View {
    @StateObject private var viewModel = HelloWorldViewModel()
    
    var body: some View {
        VStack {
            if let helloWorld = viewModel.helloWorld {
                Text(helloWorld.message)
                    .font(.largeTitle)
                    .padding()
                    .scaleEffect(viewModel.scale)
                    .overlay(
                        Text(helloWorld.message)
                            .font(.largeTitle)
                            .padding()
                            .foregroundColor(viewModel.colors[viewModel.currentColorIndex])
                            .mask(
                                LinearGradient(gradient: Gradient(colors: viewModel.colors), startPoint: .leading, endPoint: .trailing)
                                    .frame(width: viewModel.isAnimating ? 0 : nil)
                                    .animation(.easeInOut(duration: viewModel.animationInterval).repeatForever(), value: viewModel.isAnimating)
                            )
                            .scaleEffect(viewModel.scale)
                    )
                    .onAppear {
                        viewModel.startAnimations()
                    }
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        viewModel.fetchHelloWorld()
                    }
            }
        }
    }
}

#Preview {
    HelloWorldView()
}
