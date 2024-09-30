//
//  CircularProgressView.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/29/24.
//

import SwiftUI

struct CircularProgressView: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12.0)
                .foregroundColor(.white.opacity(0.2))
                .shadow(color: Color.yellow.opacity(0.6), radius: 10, x: 0, y: 0)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.orange, .red, .yellow, .green, .purple]),
                        center: .center),
                    style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(Angle(degrees: 270))
                .shadow(color: Color.purple.opacity(0.8), radius: 8, x: 0, y: 0)
                .animation(.spring(response: 1.0, dampingFraction: 0.6, blendDuration: 0.3), value: progress)
        }
        .padding()
    }
}

#Preview {
    CircularProgressView(progress: .constant(0.9))
}
