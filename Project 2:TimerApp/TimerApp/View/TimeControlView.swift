//
//  TimeControlView.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/30/24.
//

import SwiftUI

struct TimeControlView: View {
    @Binding var timerState: TimerState
    
    var body: some View {
        HStack(spacing: 30) {
            ActionButton(title: "Cancel", action: { timerState = .idle }, style: .cancel)
            Spacer()
            switch timerState {
            case .idle:
                ActionButton(title: "Start", action: { timerState = .running }, style: .start)
            case .running, .resumed:
                ActionButton(title: "Pause", action: { timerState = .paused }, style: .pause)
            case .paused:
                ActionButton(title: "Resume", action: { timerState = .resumed }, style: .resume)
            case .restart:
                ActionButton(title: "Restart", action: { timerState = .running }, style: .resume)
            }
            
        }
        .padding()
        .animation(.easeInOut, value: timerState) // Animate button appearance
    }
}

struct ActionButton: View {
    var title: String
    var action: () -> Void
    var style: TimerControlButtonStyle
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
        }
        .buttonStyle(style)
    }
}

#Preview {
    TimeControlView(timerState: .constant(.idle))
        .preferredColorScheme(.dark)
}
