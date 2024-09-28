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
