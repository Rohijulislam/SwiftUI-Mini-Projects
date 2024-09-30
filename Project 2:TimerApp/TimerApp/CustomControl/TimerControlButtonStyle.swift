//
//  TimerControlButtonStyle.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/30/24.
//

import SwiftUI

struct TimerControlButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 70)
            .foregroundColor(color)
            .background(color.opacity(0.3))
            .clipShape(Circle())
            .padding(3)
            .overlay(
                Circle()
                    .stroke(color.opacity(0.3), lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Animation for press feedback
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
