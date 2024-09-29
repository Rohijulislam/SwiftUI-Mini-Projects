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
            
            Button(action: {
                self.timerState = .idle
            }, label: {
                Text("Cancel")
                    .fontWeight(.semibold)
            }).buttonStyle(.cancel)
            
            Spacer()
            
            switch timerState {
            case .idle:
                Button(action: {
                    self.timerState = .running
                }, label: {
                    Text("Start")
                        .fontWeight(.semibold)
                })
                .buttonStyle(.start)
            case .running, .resumed:
                Button(action: {
                    self.timerState = .paused
                }, label: {
                    Text("Pause")
                        .fontWeight(.semibold)
                }).buttonStyle(.pause)
            case .paused:
                Button(action: {
                    self.timerState = .resumed
                }, label: {
                    Text("Resume")
                        .fontWeight(.semibold)
                }).buttonStyle(.resume)
                
            case .restart:
                Button(action: {
                    self.timerState = .running
                }, label: {
                    Text("Restart")
                        .fontWeight(.semibold)
                }).buttonStyle(.resume)
                
            }
            
        }
        .padding()
        .animation(.easeInOut, value: timerState) // Animate button appearance
    }
}

#Preview {
    TimeControlView(timerState: .constant(.idle))
        .preferredColorScheme(.dark)
}
