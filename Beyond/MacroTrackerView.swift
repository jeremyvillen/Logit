import SwiftData
import SwiftUI
import Charts

struct MacroTrackerView: View {
    @State private var calorieInput: String = ""
    @State private var proteinInput: String = ""
    @State private var weightInput: String = ""
    @State private var totalCalories: Int = 0
    @State private var totalProtein: Int = 0
    @State private var selectedRange: TimeRange = .lastWeek // Default range
    
    @Environment(\.modelContext) private var context
    @Query private var weightEntries: [WeightEntry] // Fetch stored weight entries
    
    @EnvironmentObject var appearance: AppearanceSettings

    var body: some View {
        ZStack {
            appearance.currentScheme.primary.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Chart displaying weight data
                    VStack(spacing: 10) {
                        if !weightEntries.isEmpty {
                            // Picker for Time Range
                            Picker("Time Range", selection: $selectedRange) {
                                ForEach(TimeRange.allCases, id: \.self) { range in
                                    Text(range.title).tag(range)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
//                            .padding(.horizontal)
                            .background(Color.gray.opacity(0.1).cornerRadius(8))
                        }

                        // Chart displaying weight data
                        if weightEntries.isEmpty {
                            Text("Enter Weight to Track Progress!")
                                .foregroundColor(appearance.currentScheme.text)
                                .padding(.top, 50) // Keep consistent spacing even when no data
                        } else {
                            Chart(extendedEntries) { entry in
                                LineMark(
                                    x: .value("Date", entry.date, unit: .day),
                                    y: .value("Weight", entry.weight)
                                )
                                .interpolationMethod(.linear)
                                .foregroundStyle(.blue)
                                .symbol(Circle())
                            }
                            .frame(height: 150)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding() // Adjust padding for consistent spacing
                        }
                    }
                    .padding(.top, 20)

                    // Weight input
                    VStack(spacing: 10) {
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
                    }

                    // Header displaying total calories and protein
                    VStack(spacing: 10) {
                        Text("Total Calories: \(totalCalories)")
                            .font(.title)
                            .foregroundColor(appearance.currentScheme.text)
                        Text("Total Protein: \(totalProtein)g")
                            .font(.title)
                            .foregroundColor(appearance.currentScheme.text)
                    }
                    .padding(.top, 20)

                    // Input fields for calories and protein
                    VStack(spacing: 20) {
                        TextField("Enter Calories", text: $calorieInput)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        TextField("Enter Protein (g)", text: $proteinInput)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        Button("Add Macros") {
                            addMacronutrients()
                        }
                        .padding()
                        .background(appearance.currentScheme.button)
                        .foregroundColor(appearance.currentScheme.buttonText)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .shadow(color: appearance.currentScheme.shadow.opacity(0.9), radius: 10)
                    }
                    .padding(.top, 20)
                }
                .padding(.bottom, 40) // Add space at the bottom for better scrolling
            }
        }
        .navigationBarTitle("Macronutrient Tracker", displayMode: .inline)
    }

    // MARK: - Filtered Entries Based on Time Range
    private var extendedEntries: [WeightEntry] {
        guard let rangeStart = selectedRange.startDate else { return [] }
        
        let now = Date()
        let sortedEntries = weightEntries.sorted(by: { $0.date < $1.date })
        
        var extended = sortedEntries.filter { $0.date >= rangeStart && $0.date <= now }
        
        // Add the first data point at the start of the range if needed
        if let first = sortedEntries.first, first.date > rangeStart {
            extended.insert(WeightEntry(date: rangeStart, weight: first.weight), at: 0)
        }
        
        return extended
    }

    // MARK: - Function to Add Data
    private func addWeight() {
        guard let weight = Double(weightInput) else { return }
        let newEntry = WeightEntry(date: Date(), weight: weight)
        context.insert(newEntry)

        do {
            try context.save()
            DispatchQueue.main.async {
                weightInput = ""
            }
        } catch {
            print("Error saving weight entry: \(error)")
        }
    }
    
    private func addMacronutrients() {
        if let calories = Int(calorieInput), let protein = Int(proteinInput) {
            totalCalories += calories
            totalProtein += protein
        }
        // Clear inputs
        calorieInput = ""
        proteinInput = ""
    }
}

// MARK: - TimeRange Enum
enum TimeRange: CaseIterable {
    case lastWeek, lastMonth, lastSixMonths

    var title: String {
        switch self {
        case .lastWeek: return "Last Week"
        case .lastMonth: return "Last Month"
        case .lastSixMonths: return "Last 6 Months"
        }
    }

    var startDate: Date? {
            let calendar = Calendar.current
            let now = Date()

            switch self {
            case .lastWeek:
                return calendar.date(byAdding: .day, value: -7, to: now)
            case .lastMonth:
                return calendar.date(byAdding: .month, value: -1, to: now)
            case .lastSixMonths:
                return calendar.date(byAdding: .month, value: -6, to: now)
        }
    }
}

#Preview {
    MacroTrackerView()
        .environmentObject(AppearanceSettings())
        .modelContainer(for: [WeightEntry.self]) // Provide the model container
}
