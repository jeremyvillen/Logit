import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var appearance: AppearanceSettings

    @Binding var workout: Workouts
    
    var onSave: (Workouts) -> Void

    @State private var isAddWorkoutViewPresented = false

    var body: some View {
        NavigationView {
            ZStack {
                appearance.currentScheme.editWorkoutBackground.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("\(workout.name) Exercises")
                        .font(.custom("Exo", size: 40))
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 10) {

                            Text("Exercises:")
                                .font(.headline)
                                .foregroundColor(appearance.currentScheme.editWorkoutText)
                        
                        List {
                            ForEach(workout.exercises, id: \.self) { exercise in
                                HStack (spacing: 10) {
                                    Text(exercise.name)
                                        .font(.custom("Exo", size: 18))
                                        .foregroundColor(appearance.currentScheme.editWorkoutText)
                                    Spacer()
                                    Text("3RM: ")
                                        .foregroundColor(appearance.currentScheme.editWorkoutText)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        deleteExercise(exercise)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                .frame(maxWidth: .infinity, minHeight: 40)
                                        .background(
                                            Rectangle()
                                                .fill(appearance.currentScheme.editWorkoutRow)
                                    )
                            }
                            .listRowBackground(appearance.currentScheme.editWorkoutRow)
                        }
                        .listStyle(PlainListStyle()) // Use plain style for edge-to-edge look

                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                    }
                    
                    Spacer()
                    
                    Button("Add Exercises") {
                        isAddWorkoutViewPresented = true
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    HStack(spacing: 20) {
                        Button("Save Changes") {
                            saveWorkout()
                        }
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding(.bottom)
                }
                .padding()
            }
            .sheet(isPresented: $isAddWorkoutViewPresented) {
                AddWorkoutView(
                    isPresented: $isAddWorkoutViewPresented,
                    workouts: .constant([]), // Adjust this as needed
                    selectedWorkout: workout,
                    selectedMuscle: workout.name,
                    onSave: { updatedWorkout in
                        workout = updatedWorkout // Update the workout with changes
                    }
                )
                .onDisappear {
                    // Call the onSave closure when AddWorkoutView is dismissed
                    onSave(workout)
                }
                .environmentObject(appearance)
                .environmentObject(EquipmentList.shared)
            }
        }
    }

    // MARK: - Actions

    private func deleteExercise(_ exercise: Exercise) {
        print("Attempting to delete exercise: \(exercise.name)")
        if let index = workout.exercises.firstIndex(of: exercise) {
            workout.exercises.remove(at: index)
            context.delete(exercise)
            print("Exercise deleted from context.")
            do {
                try context.save()
                print("Context saved successfully.")
            } catch {
                print("Error saving context: \(error)")
            }
        } else {
            print("Exercise not found in workout.")
        }
    }
    
    private func saveWorkout() {
        do {
            try context.save()
            print("Workout saved successfully.")
            onSave(workout)
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving workout: \(error)")
        }
    }
}

#Preview {
    ExerciseListView(
        workout: .constant(Workouts(name: "Chest", category: "Strength", exercises: [
            Exercise(name: "Bench Press", muscle: "Chest", category: "Strength", equipment: []),
            Exercise(name: "Push-Ups", muscle: "Chest", category: "Bodyweight", equipment: [])
        ], images: "chest_icon")),
        onSave: { _ in }
    )
    .environmentObject(AppearanceSettings())
}
