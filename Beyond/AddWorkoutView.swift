import SwiftUI
import SwiftData


struct AddWorkoutView: View {
    @Binding var isPresented: Bool
    @Binding var workouts: [Workouts]
    
    @Environment(\.modelContext) private var context
    @EnvironmentObject var appearance: AppearanceSettings
    @EnvironmentObject var equipmentList: EquipmentList

    @State private var workoutName = ""
    @State private var selectedExerciseIDs: Set<UUID> = []
    @State private var errorMessage: String?
    @State private var allExercises: [Exercise] = Exercise.allExercises.filter { exercise in
        exercise.equipment.allSatisfy { equipment in
            EquipmentList.shared.items.first { $0.name == equipment.name }?.isAvailable ?? false
        }
    }
    
    var selectedWorkout: Workouts // The workout being modified
    var selectedMuscle: String?   // Muscle group to filter exercises
    var onSave: (Workouts) -> Void // Closure to pass back the updated workout


    var filteredExercises: [Exercise] {
        allExercises.filter { exercise in
            exercise.muscle == selectedMuscle
        }
    }
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color.black.opacity(0.9).ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Add Exercises for \(selectedMuscle ?? "Workout")")
                            .font(.custom("Exo", size: 24))
                            .foregroundColor(.white)

                        if filteredExercises.isEmpty {
                            Text("No exercises available for \(selectedMuscle ?? "this muscle").")
                                .foregroundColor(.gray)
                                .italic()
                        } else {
                            List(filteredExercises, id: \.id) { exercise in
                                HStack {
                                    Text(exercise.name)
                                        .foregroundColor(appearance.currentScheme.addWorkoutText)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedExerciseIDs.contains(exercise.id) ? appearance.currentScheme.addWorkoutRow : appearance.currentScheme.addWorkoutSelect)
                                )
                                .onAppear {
                                    print("Rendering row for \(exercise.name). Selected: \(selectedExerciseIDs.contains(exercise.id))")
                                }
                                .onTapGesture {
                                    toggleExerciseSelection(exercise)
                                }
                            
                            }
                            .scrollContentBackground(.hidden)
                        }

                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.footnote)
                                .padding(.top, 5)
                        }

                        HStack {
                            Button("Save Changes") {
                                saveWorkoutChanges()
                            }
                            .padding()
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(10)

                            Button("Cancel") {
                                isPresented = false
                            }
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.top)
                    }
                    .onAppear {
                        initializeSelectedExercises()
                    }
                }
            }
        }
    // MARK: - Actions

    private func initializeSelectedExercises() {
        // Populate selectedExerciseIDs with the exercises already in the workout
        selectedExerciseIDs = Set(selectedWorkout.exercises.map { $0.id })
        print("Initialized selected exercises: \(selectedExerciseIDs)")

    }


    private func toggleExerciseSelection(_ exercise: Exercise) {
        // Add or remove the exercise ID from the selectedExerciseIDs set
        if selectedExerciseIDs.contains(exercise.id) {
            selectedExerciseIDs.remove(exercise.id)
        } else {
            selectedExerciseIDs.insert(exercise.id)
        }
    }

    private func saveWorkoutChanges() {
            guard !selectedExerciseIDs.isEmpty else {
                errorMessage = "Please select at least one exercise."
                return
            }

            // Update the workout's exercises
            let updatedExercises = allExercises.filter { selectedExerciseIDs.contains($0.id) }
            var updatedWorkout = selectedWorkout
            updatedWorkout.exercises = updatedExercises

            // Save changes
            onSave(updatedWorkout)
            isPresented = false
    }
}
#Preview {
    // Sample exercises
    let sampleExercises = [
        Exercise(name: "Bench Press", muscle: "Chest", category: "Strength", equipment: []),
        Exercise(name: "Push-Ups", muscle: "Chest", category: "Bodyweight", equipment: []),
        Exercise(name: "Incline Dumbbell Press", muscle: "Chest", category: "Strength", equipment: []),
        Exercise(name: "Cable Flyes", muscle: "Chest", category: "Strength", equipment: [])
    ]
    
    // Example workout with some exercises pre-selected
    let exampleWorkout = Workouts(
        name: "Chest Day",
        category: "Strength",
        exercises: [
            sampleExercises[0], // Bench Press
            sampleExercises[1]  // Push-Ups
        ],
        images: "chest_icon"
    )
    
    AddWorkoutView(
        isPresented: .constant(true),
        workouts: .constant([]),
        selectedWorkout: exampleWorkout,  // Pass the example workout
        selectedMuscle: "Chest",          // Filter exercises by "Chest"
        onSave: { updatedWorkout in
            print("Updated workout: \(updatedWorkout.name) with \(updatedWorkout.exercises.count) exercises.")
        }
    )
    .environmentObject(AppearanceSettings()) // Provide environment objects
    .environmentObject(EquipmentList.shared)
    .modelContainer(for: Workouts.self)
}
