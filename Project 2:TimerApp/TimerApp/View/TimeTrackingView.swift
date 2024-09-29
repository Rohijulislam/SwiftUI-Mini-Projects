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
                Text(formattedTimeStamp())
                    .font(.largeTitle)
                HStack {
                    Image(systemName: "bell.fill")
                    Text(Date.now.addingTimeInterval(Double(remainingTimeInSeconds)), format: .dateTime.hour().minute())
                }
            }
        }
    }
    
    private func formattedTimeStamp() -> String {
        let hour = remainingTimeInSeconds / 3600
        let sec = max(remainingTimeInSeconds % 60, 0)
        let min = (remainingTimeInSeconds - sec - hour * 3600 ) / 60
        
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
}
