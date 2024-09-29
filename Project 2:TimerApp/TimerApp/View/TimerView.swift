//
//  TimerView.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/29/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = TimerViewModel()
    var body: some View {
        VStack(spacing: 40) {
            if viewModel.state == .idle {
                TimePickerView { sec in
                    viewModel.totalTimeSelectedInSeconds = sec
                }
            } else {
                TimeTrackingView(progress: $viewModel.progress, remainingTimeInSeconds: $viewModel.remainingTimeInSeconds)
            }
            TimeControlView(timerState: $viewModel.state)
            Spacer()
        }
        .padding(.all, 40)
        .onReceive(viewModel.$isFinishedPlayingTimer) { isFinished in
            if isFinished {
                viewModel.playSystemSound()
            }
        }
    }
}

#Preview {
    TimerView()
}
