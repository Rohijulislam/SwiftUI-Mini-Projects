//
//  TimePickerView.swift
//  TimerApp
//
//  Created by Md. Rohejul Islam on 9/29/24.
//

import SwiftUI

struct TimePickerView: View {
    @StateObject private var viewModel = TimePickerViewModel()
    var onTimeSelected: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            // Display the selected time
            Text(viewModel.formattedTime)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            HStack(spacing: 20) {
                // Hour picker
                RangePickerView(title: "hrs", range: 0..<24, selectedValue: $viewModel.selectedHour)
                // Minute Picker
                RangePickerView(title: "min", range: 0..<60, selectedValue: $viewModel.selectedMinute)
                // Second Picker
                RangePickerView(title: "sec", range: 0..<60, selectedValue: $viewModel.selectedSecond)
            }
            .padding()
            
            // Total time display
            Text("Total Time in Seconds: \(viewModel.totalTimeInSeconds)")
                .font(.headline)
                .padding()
                .onChange(of: viewModel.totalTimeInSeconds) { oldValue, newValue in
                    onTimeSelected(newValue)
                }
        }
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(radius: 8)
        .navigationTitle("Time Picker")
        .preferredColorScheme(.dark)
        .padding(.all, 30)
    }
}


struct RangePickerView: View {
    var title: String
    var range: Range<Int>
    @Binding var selectedValue: Int
    
    var body: some View {
        VStack {
            Picker(title, selection: $selectedValue) {
                ForEach(range, id: \.self) { value in
                    Text("\(value) \(title.lowercased())").tag(value)
                        .foregroundColor(.primary)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100)
            .clipped()
        }
        .onAppear {
            if !range.contains(selectedValue) {
                selectedValue = range.lowerBound // Set to minimum if out of range
            }
        }
    }
}


#Preview {
    TimePickerView(onTimeSelected: { _ in
    })
}
