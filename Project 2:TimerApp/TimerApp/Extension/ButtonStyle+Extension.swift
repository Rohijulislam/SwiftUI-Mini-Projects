//
//  ButtonStyle+Extension.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/30/24.
//

import SwiftUI

extension ButtonStyle where Self == TimerControlButtonStyle {
    static var pause: TimerControlButtonStyle {
        TimerControlButtonStyle(color:Color("PauseColor"))
    }
    
    static var start: TimerControlButtonStyle {
        TimerControlButtonStyle(color: Color("StartColor"))
    }
    
    static var cancel: TimerControlButtonStyle {
        TimerControlButtonStyle(color:Color("CancelColor"))
    }
    
    static var resume: TimerControlButtonStyle {
        TimerControlButtonStyle(color:Color("ResumeColor"))
    }
}
