//
//  TimePickerViewModel.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/30/24.
//

import Foundation

class TimePickerViewModel: ObservableObject {
    @Published var selectedHour: Int = 0
    @Published var selectedMinute: Int = 0
    @Published var selectedSecond: Int = 0
    
    var totalTimeInSeconds: Int {
        (selectedHour * 3600) + (selectedMinute * 60) + selectedSecond
    }
    
    var formattedTime: String {
        String(format: "%02d:%02d:%02d", selectedHour, selectedMinute, selectedSecond)
    }
}
