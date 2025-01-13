import SwiftUI
import Charts
import SwiftData

struct WeightTrackerView: View {
    @Environment(\.modelContext) private var context
    @Query private var weightData: [WeightEntry] // Fetch weight data stored in SwiftData
    
    @State private var weightInput: String = ""
    
    @EnvironmentObject var appearance: AppearanceSettings

    var body: some View {
        ZStack {
            appearance.currentScheme.primary.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // Chart to display weight data
                Chart(weightData) { data in
                    LineMark(
                        x: .value("Date", data.date, unit: .day),
                        y: .value("Weight", data.weight)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(.blue)
                    .symbol(Circle())              }
                .frame(height: 300)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
                
                // Input for weight
                TextField("Enter Weight (lbs)", text: $weightInput)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button("Add Weight") {
                    addWeight()
                }
                .padding()
                .background(appearance.currentScheme.button)
                .foregroundColor(appearance.currentScheme.buttonText)
                .cornerRadius(8)
                .padding(.horizontal)
                .shadow(color: appearance.currentScheme.shadow.opacity(0.9), radius: 10)
                
                Spacer()
            }
        }
    }
    
    // Function to add a weight entry to SwiftData
    private func addWeight() {
        guard let weight = Double(weightInput) else { return }
        
        let newEntry = WeightEntry(date: Date(), weight: weight)
        context.insert(newEntry)
        
        do {
            try context.save() // Save the new weight entry
            weightInput = ""  // Clear the input field
        } catch {
            print("Error saving weight entry: \(error)")
        }
    }
}

#Preview {
    WeightTrackerView()
        .environmentObject(AppearanceSettings())
        .modelContainer(for: [WeightEntry.self])
}
