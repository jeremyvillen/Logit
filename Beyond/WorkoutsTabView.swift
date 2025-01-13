import SwiftUI
import SwiftData

struct WorkoutsTabView: View {
    @Binding var workouts: [Workouts]
    @Binding var isExerciseListPresented: Bool
    @Binding var workoutToEdit: Workouts?
    @Binding var selectedMuscle: String?

    
    let onDelete: (Workouts) -> Void
    let onUpdate: (Workouts) -> Void
    
    @EnvironmentObject var appearance: AppearanceSettings
    @EnvironmentObject var equipmentList: EquipmentList
    
    var body: some View {
        ZStack {
            appearance.currentScheme.primary
            VStack {
                Text("Workouts")
                    .font(.custom("Exo", size: 24))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 10)
                
                ScrollView {
                    VStack(spacing: 10) { // Vertical list with spacing
                        ForEach(workouts, id: \.id) { workout in
                            Button(action: {
                                workoutToEdit = workout
                                isExerciseListPresented = true
                            }) {
                                HStack (spacing: 0){
                                    // Workout Image
                                    Image(workout.name.lowercased()) // Assuming image names match workout names in lowercase
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipped()

                                    
                                    // Workout Details
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(workout.name)
                                            .font(.custom("Exo", size: 20))
                                            .foregroundColor(appearance.currentScheme.text)
                                        Text("\(workout.exercises.count) Favorite Exercises")
                                            .font(.custom("Exo", size: 14))
                                            .foregroundColor(.white)
                                    }
                                    .padding(.leading, 10)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: 60) // Set consistent button height
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(appearance.currentScheme.addWorkoutRow)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 3)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 10) // Add padding to the list
                }
            }
            .padding()
        }
        .sheet(isPresented: $isExerciseListPresented) {
            if let workout = workoutToEdit {
                ExerciseListView(
                    workout: .constant(workout),
                    onSave: { updatedWorkout in
                        if let index = workouts.firstIndex(where: { $0.id == updatedWorkout.id }) {
                            workouts[index] = updatedWorkout
                        }
                        isExerciseListPresented = false
                    }
                )
                .environmentObject(appearance)
                .environmentObject(equipmentList)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    WorkoutsTabView(
        workouts: .constant(Workouts.predefinedStrengthWorkouts),
        isExerciseListPresented: .constant(false),
        workoutToEdit: .constant(nil),
        selectedMuscle: .constant(nil),
        onDelete: { _ in },
        onUpdate: { _ in }
    )
    .environmentObject(AppearanceSettings())
    .environmentObject(EquipmentList())
}
