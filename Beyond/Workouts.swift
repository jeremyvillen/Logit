import Foundation
import SwiftData

@Model
class Workouts: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var category: String
    var exercisesJSON: String
    var images: String
    // Computed property to manage exercises encoding/decoding
    var exercises: [Exercise] {
        get {
            if let data = exercisesJSON.data(using: .utf8) {
                return (try? JSONDecoder().decode([Exercise].self, from: data)) ?? []
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                exercisesJSON = String(data: data, encoding: .utf8) ?? "[]"
            }
        }
    }
    
    // Initializer
    init(name: String, category: String, exercises: [Exercise] = [], images: String) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.images = images
        self.exercisesJSON = ""
        self.exercises = exercises
    }
    
    // Predefined Workouts
    static var predefinedStrengthWorkouts: [Workouts] {
        // Filter exercises by muscle or category
        let allExercises = Exercise.allExercises
        
        return [
            Workouts(
                name: "Abs",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Abs" && ["Crunch", "Plank", "Russian Twist", "Leg Raise", "Mountain Climber", "Sit Up", "Flutter Kicks" ].contains($0.name) },
                images: "chest_icon"
            ),
            Workouts(
                name: "Back",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Back" && ["Pull-Up", "Deadlift", "Lat Pulldown", "Chin-Up", "Seated Cable Row", "Barbell Row", "Dumbbell Row", "Dumbbell Row"].contains($0.name) },
                images: "chest_icon"
            ),
            Workouts(
                name: "Biceps",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Biceps" && ["Dumbbell Curl", "Incline Dumbbell Curl", "Hammer Curl", "Preacher Curl", "Barbell Curl",].contains($0.name) },
                images: "chest_icon"
            ),
            
            Workouts(
                name: "Calves",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Calves" && ["Seated Calf Raise", "Leg Press Calf Raise", "Machine Calf Raise"].contains($0.name) },
                images: "chest_icon"
            ),
            
            Workouts(
                name: "Chest",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Chest" && ["Bench Press", "Incline Bench Press", "Dumbbell Bench Press", "Incline Dumbbell Bench Press", "Push-Up", "Cable Chest Flies", "Dumbbell Chest Flies"].contains($0.name) },
                images: "chest_icon"
            ),
            Workouts(
                name: "Forearms",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Forearms" && ["Wrist Curl", "Behind-The-Back Wrist Curl", "Finger Curl"].contains($0.name) },
                images: "chest_icon"
            ),
            Workouts(
                name: "Glutes",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Glutes" && ["Barbell Hip Thrust", "Smith-Machine Hip Thrust", "Dumbbell Hip Thrust ", "Glute Bridge", "Back Squat", "Cable Kickback", "Step-Up", "Donkey Kick"].contains($0.name) },
                images: "chest_icon"
            ),
            Workouts(
                name: "Hamstrings",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Hamstrings" && ["Romanian Deadlift", "Dumbbell Romanian Deadlift", "Lying Hamstring Curl", "Seated Hamstring Curl", "Nordic Hamstring Curl"].contains($0.name) },
                images: "chest_icon"
            ),
            Workouts(
                name: "Quads",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Quads" && ["Barbell Back Squat", "Barbell Front Squat", "Leg Press ", "Walking Lunge", "Hack Squat", "Bulgarian Split Squat", "Sissy Squat"].contains($0.name) },
                images: "chest_icon"
            ),
            
            Workouts(
                name: "Shoulders",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Shoulders" && ["Barbell Shoulder Press", "Dumbbell Shoulder Press", "Lateral Raise", "Reverse Pec Deck", "Cable Rear Delt Fly", "Face Pull"].contains($0.name) },
                images: "chest_icon"
            ),
            
            Workouts(
                name: "Triceps",
                category: "Strength",
                exercises: allExercises.filter { $0.muscle == "Triceps" && ["Tricep Dips", "Cable Overhead Tricep Extension", "Tricep Pushdown ", "EZ-Bar Skull Crusher"].contains($0.name) },
                images: "chest_icon"
            ),
            // Add more workouts for other muscles as needed
        ]
    }
}
