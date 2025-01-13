import SwiftData
import SwiftUI

struct ScheduleWorkoutView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var appearance: AppearanceSettings

    let availableWorkouts: [Workouts]
    let onSave: (Workouts) -> Void

    var body: some View {
        ZStack {
            appearance.currentScheme.background
            NavigationView {
                List {
                    // List of Available Workouts
                    ForEach(availableWorkouts, id: \.id) { workout in
                        Button(action: {
                            onSave(workout) // Call the onSave closure when a workout is selected
                        }) {
                            HStack() {
                                Spacer()
                                Text(workout.name)
                                    .font(.headline)
                                    .foregroundColor(appearance.currentScheme.buttonText)
                                Spacer()
                            }
                            .padding()
                            .background(Color.cyan)
                            .cornerRadius(10)
//                            .onTapGesture(perform:)
                        }
                    }
                }
                
                .listStyle(PlainListStyle()) // Ensures consistent styling
                .scrollContentBackground(.hidden) // Hides default background in dark mode
                .background(appearance.currentScheme.primary) // Matches app theme
                .navigationTitle("Choose a Workout")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ScheduleWorkoutView(
        availableWorkouts: [Workouts(name: "Push Day", category: "Strength", images: "chest_icon"), Workouts(name: "Pull Day", category: "Strength", images: "chest_icon")], // Mock data
        onSave: { _ in }
    )
    .environmentObject(AppearanceSettings())
}
