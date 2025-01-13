
import Foundation
import SwiftData

@Model
class Exercise: Identifiable, Codable, Equatable {
    var id: UUID // Unique identifier for each exercise
    var name: String
    var muscle: String
    var category: String
    var equipment: [Equipment]
    
    
    
    
    init(id: UUID = UUID(), name: String, muscle: String, category: String, equipment: [Equipment]) {
        self.id = id
        self.name = name
        self.muscle = muscle
        self.category = category
        self.equipment = equipment
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        muscle = try container.decode(String.self, forKey: .muscle)
        category = try container.decode(String.self, forKey: .category)
        equipment = try container.decode([Equipment].self, forKey: .equipment)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(muscle, forKey: .muscle)  // Encode 'muscle'
        try container.encode(category, forKey: .category)
        try container.encode(equipment, forKey: .equipment)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, muscle, category, equipment
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id  // Compare exercises based on their unique ID
    }
    
    func isAvailable() -> Bool {
        return equipment.allSatisfy { $0.isAvailable }
    }
    
    var defaultEquipment = Equipment.defaultEquipment()
    
    // Add a static array of exercises for mocking purposes
     static var allExercises: [Exercise] {

         let sharedEquipment = EquipmentList.shared.items

         func findEquipment(named name: String) -> Equipment? {
             if let found = sharedEquipment.first(where: { $0.name == name }) {
                 return found
             } else {
                 return nil
             }
         }


        return [
            // Chest (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                name: "Bench Press", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
                name: "Incline Bench Press", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
                name: "Decline Bench Press", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
                name: "Dumbbell Bench Press", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
                name: "Incline Dumbbell Bench Press", muscle: "Chest", category: "Strength", equipment: findEquipment(named: "Dumbbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
                name: "Dumbbell Chest Flies", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000007")!,
                name: "Cable Chest Flies", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000008")!,
                name: "Push-Up", muscle: "Chest", category: "Strength", equipment: []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000009")!,
                name: "Incline Chest Fly", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000010")!,
                name: "Pec Deck Machine", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000011")!,
                name: "Machine Press", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000012")!,
                name: "Incline Push-Up", muscle: "Chest", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000013")!,
                name: "Dips (Chest Focused)", muscle: "Chest", category: "Strength", equipment:findEquipment(named: "Dip Bar").map { [$0] } ?? []),
//
//            // Back (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000014")!,
                name: "Pull-Up", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Pull-Up Bar").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000015")!,
                name: "Chin-Up", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Pull-Up Bar").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000016")!,
                name: "Lat Pulldown", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000017")!,
                name: "Single Arm Lat Pulldown", muscle: "Back", category: "Strength", equipment: findEquipment(named: "Cables").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000018")!,
                name: "Seated Cable Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000019")!,
                name: "Barbell Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000020")!,
                name: "Dumbbell Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000021")!,
                name: "T-Bar Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000022")!,
                name: "Deadlift", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000023")!,
                name: "Reverse Grip Barbell Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000024")!,
                name: "Single-Arm Cable Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
//
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000025")!,
                name: "Lat Pullovers", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),

            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000026")!,
                name: "Chest-Supported Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000027")!,
                name: "Inverted Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000028")!,
                name: "Superman Hold", muscle: "Back", category: "Stretch", equipment: []),
            
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000029")!,
                name: "Dead Hang", muscle: "Back", category: "Stretch", equipment:findEquipment(named: "Pull-Up Bar").map { [$0] } ?? []),

            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000030")!,
                name: "Landmine Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000031")!,
                name: "Wide-Grip Pull-Up", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Pull-Up Bar").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000032")!,
                name: "Neutral-Grip Pull-Up", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Pull-Up Bar").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000033")!,
                name: "Renegade Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000034")!,
                name: "Pendlay Row", muscle: "Back", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            // Biceps (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000035")!,
                name: "Barbell Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000036")!,
                name: "Dumbbell Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000037")!,
                name: "Hammer Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000038")!,
                name: "Rope Hammer Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000039")!,
                name: "Incline Dumbbell Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000040")!,
                name: "Concentration Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000041")!,
                name: "Machine Preacher Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000042")!,
                name: "Ez Bar Preacher Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000043")!,
                name: "Dumbbell Preacher Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000044")!,
                name: "Single-Arm Preacher Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000045")!,
                name: "Cable Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000046")!,
                name: "Reverse Dumbbell Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000047")!,
                name: "Reverse Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000048")!,
                name: "Zottman Curl", muscle: "Biceps", category: "Strength", equipment: findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000049")!,
                name: "Spider Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000050")!,
                name: "EZ-Bar Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000051")!,
                name: "Bayesian Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000052")!,
                name: "Seated Dumbbell Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000053")!,
                name: "Overhead Cable Curl", muscle: "Biceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            // Triceps (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000054")!,
                name: "Tricep Dips", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Dip Bar").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000055")!,
                name: "Close-Grip Bench Press", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000056")!,
                name: "Cable Overhead Tricep Extension", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000057")!,
                name: "Cable Single-Arm Overhead Tricep Extension", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000058")!,
                name: "Dumbbell Overhead Tricep Extension", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000059")!,
                name: "Dumbbell Single-Arm Overhead Tricep Extension", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000060")!,
                name: "Tricep Pushdown", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000061")!,
                name: "Single-Arm Tricep Pushdown", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000062")!,
                name: "Dumbbell Skull Crusher", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000063")!,
                name: "Diamond Push-Up", muscle: "Triceps", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000064")!,
                name: "Dumbbell Kickback", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000065")!,
                name: "Reverse Grip Tricep Pushdown", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000066")!,
                name: "Single-Arm Tricep Extension", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000067")!,
                name: "EZ-Bar Skull Crusher", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000068")!,
                name: "Machine Tricep Extension", muscle: "Triceps", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000069")!,
                name: "Bench Dip", muscle: "Triceps", category: "Strength", equipment: []),
                        
            // Quads (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000070")!,
                name: "Barbell Back Squat", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000071")!,
                name: "Barbell Front Squat", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000072")!,
                name: "Leg Press", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000073")!,
                name: "Walking Lunge", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000074")!,
                name: "Bulgarian Split Squat", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000075")!,
                name: "Hack Squat", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000076")!,
                name: "Goblet Squat", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000077")!,
                name: "Sissy Squat", muscle: "Quads", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000078")!,
                name: "Leg Extension", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
//            Exercise(name: "Wall Sit", muscle: "Quads", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000079")!,
                name: "Bodyweight Squat", muscle: "Quads", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000080")!,
                name: "Sumo Squat", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000081")!,
                name: "Dumbbell Step-Up", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000082")!,
                name: "Pistol Squat", muscle: "Quads", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000083")!,
                name: "Box Jump", muscle: "Quads", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000084")!,
                name: "Overhead Squat", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000085")!,
                name: "Jump Squat", muscle: "Quads", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000086")!,
                name: "Zercher Squat", muscle: "Quads", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            // Hamstrings (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000087")!,
                name: "Romanian Deadlift", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000088")!,
                name: "Dumbbell Romanian Deadlift", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000089")!,
                name: "Stiff-Leg Deadlift", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000090")!,
                name: "Lying Hamstring Curl (Machine)", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000091")!,
                name: "Nordic Hamstring Curl", muscle: "Hamstrings", category: "Strength", equipment: []),
                        
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000092")!,
                name: "Single-Leg Romanian Deadlift", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000093")!,
                name: "Cable Pull-Through", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000094")!,
                name: "Kettlebell Swing", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Kettlebells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000095")!,
                name: "Smith-Machine Hip Thrust", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Smith Machine").map { [$0] } ?? []),
                                                                                                            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000096")!,
                name: "Barbell Glute Bridge", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000097")!,
                name: "Seated Hamstring Curl", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000098")!,
                name: "Dumbbell Stiff-Legged Deadlift", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000099")!,
                name: "Dumbbell Glute Bridge", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            // Glutes (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000100")!,
                name: "Barbell Hip Thrust", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000101")!,
                name: "Smith-Machine Hip Thrust", muscle: "Hamstrings", category: "Strength", equipment:findEquipment(named: "Smith Machine").map { [$0] } ?? []),

            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000102")!,
                name: "Glute Bridge", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000103")!,
                name: "Bulgarian Split Squat", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000104")!,
                name: "Back Squat", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000105")!,
                name: "Lunges", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
                                                                                            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000106")!,
                name: "Cable Kickback", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000107")!,
                name: "Step-Up", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000108")!,
                name: "Donkey Kick", muscle: "Glutes", category: "Strength", equipment: []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000109")!,
                name: "Kettlebell Swing", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Kettlebells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000110")!,
                name: "Barbell Glute Bridge", muscle: "Glutes", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            
            // Shoulders (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000111")!,
                name: "Barbell Shoulder Press", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000112")!,
                name: "Dumbbell Shoulder Press", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000113")!,
                name: "Lateral Raise", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000114")!,
                name: "Front Raise", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000115")!,
                name: "Reverse Pec Deck", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000116")!,
                name: "Upright Row", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000117")!,
                name: "Face Pull", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000118")!,
                name: "Cable Lateral Raise", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000119")!,
                name: "Dumbbell Rear Delt Fly", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000120")!,
                name: "Cable Rear Delt Fly", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000121")!,
                name: "Seated Lateral Raise", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000122")!,
                name: "Dumbbell Shrug", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000123")!,
                name: "Smith Machine Overhead Press", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Smith Machine").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000124")!,
                name: "Barbell Shrug", muscle: "Shoulders", category: "Strength", equipment:findEquipment(named: "Barbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000125")!,
                name: "Wrist Curl", muscle: "Forearms", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            //Forearms
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000126")!,
                name: "Reverse Wrist Curl", muscle: "Forearms", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
                        
           Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000127")!,
            name: "Behind-the-Back Wrist Curl", muscle: "Forearms", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000128")!,
                name: "Finger Curl", muscle: "Forearms", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000129")!,
                name: "Cable Wrist Curl", muscle: "Forearms", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000130")!,
                name: "Cable Reverse Wrist Curl", muscle: "Forearms", category: "Strength", equipment:findEquipment(named: "Cables").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000131")!,
                name: "Dumbbell Wrist Twist", muscle: "Forearms", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000132")!,
                name: "Rope Machine", muscle: "Forearms", category: "Cardio", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            // Calves (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000133")!,
                name: "Seated Calf Raise", muscle: "Calves", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000134")!,
                name: "Single-Leg Calf Raise", muscle: "Calves", category: "Strength", equipment:findEquipment(named: "Dumbbells").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000135")!,
                name: "Leg Press Calf Raise", muscle: "Calves", category: "Strength", equipment:findEquipment(named: "Machines").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000136")!,
                name: "Smith Machine Calf Raise", muscle: "Calves", category: "Strength", equipment:findEquipment(named: "Smith Machine").map { [$0] } ?? []),
            
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000137")!,
                name: "Machine Calf Raise", muscle: "Calves", category: "Strength", equipment:findEquipment(named: " Machines").map { [$0] } ?? []),
                        
            
            // Abs (Strength)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000138")!,
                name: "Crunch", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000139")!,
                name: "Plank", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000140")!,
                name: "Russian Twist", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000141")!,
                name: "Leg Raise", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000142")!,
                name: "Bicycle Crunch", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000143")!,
                name: "Mountain Climber", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000144")!,
                name: "V-Ups", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000145")!,
                name: "Reverse Crunch", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000146")!,
                name: "Sit-Up", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000147")!,
                name: "Side Plank", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000148")!,
                name: "Hanging Leg Raise", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000149")!,
                name: "Ab Rollout", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000150")!,
                name: "Flutter Kicks", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000151")!,
                name: "Toe Touches", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000152")!,
                name: "Jackknife Sit-Up", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000153")!,
                name: "Legs-Up Crunch", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000154")!,
                name: "Windshield Wipers", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000155")!,
                name: "Cable Woodchopper", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000156")!,
                name: "Lying Leg Raise with Hip Lift", muscle: "Abs", category: "Strength", equipment: []),
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000157")!,
                name: "Standing Oblique Crunch", muscle: "Abs", category: "Strength", equipment: []),
            
            // Cardio (Cardio)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000158")!,
                name: "Jumping Jacks", muscle: "Cardio", category: "Cardio", equipment: []),
            
            // Stretching (Stretching)
            Exercise(id: UUID(uuidString: "00000000-0000-0000-0000-000000000159")!,
                name: "Yoga Stretch", muscle: "Stretching", category: "Stretching", equipment: [])
        ]
        
    }
    
}
