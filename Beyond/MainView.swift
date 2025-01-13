import SwiftUI
import SwiftData

struct MainView: View {
    // Workout Tab Variables
    @Environment(\.modelContext) private var context
    @Query private var dataItems: [Dataitem]
    @Query private var coreDataWorkouts: [Workouts]
    @State private var workouts = Workouts.predefinedStrengthWorkouts
    @State private var isAddWorkoutPresented = false
    @State private var isExerciseListPresented = false
    @State private var workoutToEdit: Workouts? = nil
    @EnvironmentObject var availableEquipment: EquipmentList

    @State private var selectedDate = Date()
    private let calendar = Calendar.current
    private let today = Date()
    @State private var selectedTab = 1
    @State private var workoutsForDates: [Date: [Workouts]] = [:]
    @State private var isScheduleWorkoutPresented = false
    @State private var selectedWorkoutDate: Date? = nil
    @State private var selectedMuscle: String? = nil

    
    @State private var isSettingsVisible = false
    @EnvironmentObject var appearance: AppearanceSettings


    var body: some View {
        // Debugging print

        // MARK: - Workouts Tab
        ZStack {
            TabView(selection: $selectedTab) {
                // Workouts Tab
                WorkoutsTabView(
                    workouts: $workouts,
                    isExerciseListPresented: $isExerciseListPresented,  workoutToEdit: $workoutToEdit, selectedMuscle: $selectedMuscle,
                    onDelete: deleteWorkout, onUpdate: updateWorkout
                )

//                .background(appearance.currentScheme.background)
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("Workouts")
                }
                .tag(0)
// MARK: - Home Tab
                HomeTabView(
                    selectedDate: $selectedDate,
                    workouts: $workouts,
                    workoutsForDates: $workoutsForDates,
                    isScheduleWorkoutPresented: $isScheduleWorkoutPresented,
                    selectedWorkoutDate: $selectedWorkoutDate,
                    isSettingsVisible: $isSettingsVisible
                )
//                .background(appearance.currentScheme.background)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Home")
                }
                .tag(1)
// MARK: - Macro Tracker
                MacroTrackerView()
                    .background(appearance.currentScheme.background)
                    .tabItem {
                    Image(systemName: "carrot")
                    Text("Calories")
                }
                .tag(2)
            }
            .toolbarBackground(.visible, for: .tabBar)
//            .accentColor(appearance.currentScheme.accent)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)


        }
    }
// MARK: - Function Declarations


    func deleteWorkout(_ workout: Workouts) {
        context.delete(workout)
        do {
            try context.save()
            workouts.removeAll { $0.id == workout.id }
            print("Workout deleted successfully. Remaining: \(workouts.count)")
        } catch {
            print("Error deleting workout: \(error)")
        }
    }

    func updateWorkout(_ updatedWorkout: Workouts) {
        do {
            try context.save()
            if let index = workouts.firstIndex(where: { $0.id == updatedWorkout.id }) {
                workouts[index] = updatedWorkout
            }
        } catch {
            print("Error updating workout: \(error)")
        }
    }

    private func currentMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: today)
    }
}

#Preview {
    let previewAppearance = AppearanceSettings()
    
    MainView()
        .environmentObject(previewAppearance)
        .environmentObject(EquipmentList.shared)
        .modelContainer(for: Workouts.self)
}
