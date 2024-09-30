//
//  TimeTrackingView.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/30/24.
//

import SwiftUI

struct TimeTrackingView: View {
    @Binding var progress: Float
    @Binding var remainingTimeInSeconds: Int
    
    var body: some View {
        ZStack {
            CircularProgressView(progress: $progress)
            
            VStack(spacing: 20) {
                Text(formattedTimeStamp)
                    .font(.largeTitle)
                
                HStack {
                    Image(systemName: "bell.fill")
                    Text(countdownTargetDate, format: .dateTime.hour().minute())
                }
            }
        }
    }
    
    // Computed property for formatted time stamp
    private var formattedTimeStamp: String {
        let hour = remainingTimeInSeconds / 3600
        let minute = (remainingTimeInSeconds % 3600) / 60
        let second = remainingTimeInSeconds % 60
        
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
    
    // Computed property for the target time when the timer ends
    private var countdownTargetDate: Date {
        Date().addingTimeInterval(Double(remainingTimeInSeconds))
    }
}
