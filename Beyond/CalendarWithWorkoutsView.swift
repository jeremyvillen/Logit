//
//  CalendarWithWorkoutsView.swift
//  Beyond
//
//  Created by Jeremy Villeneuve on 11/24/24.
//

import SwiftUI
import SwiftData

struct CalendarWithWorkoutsView: View {
    @Binding var selectedDate: Date
    let today: Date = Date()
    @State private var isScheduleWorkoutPresented = false
    var availableWorkouts: [Workouts] // List of all created workouts
    @Binding var workoutsForDates: [Date: [Workouts]] // Scheduled workouts by date
    var onAddWorkoutToDate: (Date, Workouts) -> Void // Callback to add a workout to a date
    
    @EnvironmentObject var appearance: AppearanceSettings


    var body: some View {
        VStack {
            CalendarGrid(selectedDate: $selectedDate)
                .padding()
            
            Divider()
                .background(Color.white)
            
            VStack {
                if let workouts = workoutsForDates[selectedDate.startOfDay], !workouts.isEmpty {
                    Text("Workouts for \(formattedDate(selectedDate)):")
                        .font(.headline)
                        .foregroundColor(appearance.currentScheme.text)
                        .padding(.bottom, 5)
                    ForEach(workouts, id: \.id) { workout in
                        Text(workout.name)
                            .font(.body)
                            .padding()
                            .background(appearance.currentScheme.background.opacity(0.2))
                            .cornerRadius(8)
                    }
                } else {
                    Button(action: {
                        isScheduleWorkoutPresented.toggle()
                    }) {
                        Text("Schedule Workout")
                            .foregroundColor(appearance.currentScheme.text)
                    }
                }
            }
            .padding()
            .sheet(isPresented: $isScheduleWorkoutPresented) {
                ScheduleWorkoutView(
                    availableWorkouts: availableWorkouts,
                    onSave: { workout in
                        onAddWorkoutToDate(selectedDate.startOfDay, workout)
                    }
                )
            }
        }
        .padding()
    }
    
    private func currentMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: today)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// Helper: Normalize Date to Start of Day
extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
#Preview {
    CalendarWithWorkoutsView(
            selectedDate: .constant(Date()),
            availableWorkouts: [], // Example data
            workoutsForDates: .constant([:]), // Example data
            onAddWorkoutToDate: { _, _ in } // Placeholder
        )
    .environmentObject(AppearanceSettings())

}
