//
//  TimerViewModel.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/29/24.
//

import Foundation
import AudioToolbox

class TimerViewModel: ObservableObject {
    @Published var state: TimerState = .idle {
        didSet {
            // Apply condition after the state changes
            if state != .idle, totalTimeSelectedInSeconds == 0 {
                state = .idle
                print("Reverted to idle since no time was selected.")
            } else {
                switch state {
                case .idle:
                    stopTimer()
                    remainingTimeInSeconds = 0
                    totalTimeSelectedInSeconds = 0
                case .paused, .restart:
                    stopTimer()
                case .running:
                    progress = 1.0
                    remainingTimeInSeconds = totalTimeSelectedInSeconds
                    startTimer()
                case .resumed:
                    startTimer()
                }
            }
        }
    }
    
    @Published var progress: Float = 0.0
    @Published var remainingTimeInSeconds = 0
    var totalTimeSelectedInSeconds: Int = 0
    private var timer: Timer?
    @Published var isFinishedPlayingTimer: Bool = false
    
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
    
}

extension TimerViewModel {
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            self.remainingTimeInSeconds -= 1
            self.progress = Float(self.remainingTimeInSeconds) / Float(self.totalTimeSelectedInSeconds)
            if self.remainingTimeInSeconds < 0, self.state != .idle {
                self.state = .restart
                self.isFinishedPlayingTimer = true
            }
            
            print("Time remaining : \(self.remainingTimeInSeconds) sec")
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
