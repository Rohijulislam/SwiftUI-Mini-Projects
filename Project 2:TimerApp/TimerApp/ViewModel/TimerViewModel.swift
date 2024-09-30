//
//  TimerViewModel.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/29/24.
//

import Foundation
import AudioToolbox

class TimerViewModel: ObservableObject {
    @Published var progress: Float = 0.0
    @Published var remainingTimeInSeconds = 0
    @Published var isFinishedPlayingTimer: Bool = false
    @Published var state: TimerState = .idle {
        didSet {
            handleStateChange()
        }
    }
    
    var totalTimeSelectedInSeconds: Int = 0
    private var timer: Timer?
    
    // MARK: - Public methods
    
    func formattedTimeStamp() -> String {
        let hour = remainingTimeInSeconds / 3600
        let sec = max(remainingTimeInSeconds % 60, 0)
        let min = (remainingTimeInSeconds - sec - hour * 3600 ) / 60
        
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    func playSystemSound() {
        AudioServicesPlaySystemSound(1005)  // Replace 1005 with the desired system sound ID
        isFinishedPlayingTimer = false
    }
    
    // MARK: - Private methods
    
    private func handleStateChange() {
        guard totalTimeSelectedInSeconds > 0 else {
            revertToIdleState()
            return
        }
        
        switch state {
        case .idle:
            resetTimer()
        case .paused, .restart:
            stopTimer()
        case .running:
            startRunningTimer()
        case .resumed:
            startTimer()
        }
    }
    
    private func revertToIdleState() {
        guard state != .idle else { return }
        state = .idle
        print("Reverted to idle since no time was selected.")
    }
    
    private func handleTimerCompletion() {
        remainingTimeInSeconds = 0
        if state != .idle {
            state = .restart
            isFinishedPlayingTimer = true
        }
    }
    
}

extension TimerViewModel {
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            self.remainingTimeInSeconds -= 1
            self.progress = Float(self.remainingTimeInSeconds) / Float(self.totalTimeSelectedInSeconds)
            if self.remainingTimeInSeconds < 0 {
                self.handleTimerCompletion()
            }
            print("Time remaining : \(self.remainingTimeInSeconds) sec")
        })
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startRunningTimer() {
        progress = 1.0
        remainingTimeInSeconds = totalTimeSelectedInSeconds
        startTimer()
    }
    
    private func resetTimer() {
        stopTimer()
        remainingTimeInSeconds = 0
        totalTimeSelectedInSeconds = 0
    }
    
}
