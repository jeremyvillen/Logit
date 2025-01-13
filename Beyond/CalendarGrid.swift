import SwiftUI

struct CalendarGrid: View {
    @Binding var selectedDate: Date
    let today: Date = Date()
    @EnvironmentObject var appearance: AppearanceSettings   
    private let calendar = Calendar.current
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        VStack {
            Text(currentMonthYear())
                .foregroundColor(appearance.currentScheme.text)
                .font(.custom("Exo", size: 20))
                .fontWeight(.bold)
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.custom("Exo", size: 15))
                        .foregroundColor(appearance.currentScheme.text)
                        .frame(maxWidth: .infinity)
                }
            }

            // Days in the Week Grid
            let days = weekDays()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(0..<days.count, id: \.self) { index in
                    if let date = days[index] {
                        Text("\(calendar.component(.day, from: date))")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(8)
                            .font(.custom("Exo", size: 10))
                            .foregroundColor(appearance.currentScheme.text)
                            .background(
                                calendar.isDate(date, inSameDayAs: today) ?
                                appearance.currentScheme.calendarToday.opacity(0.8) : // Highlight today
                                    calendar.isDate(date, inSameDayAs: selectedDate) ?
                                appearance.currentScheme.calendarChoose.opacity(0.8) : // Highlight selected date
                                        Color.clear
                            )
                            .foregroundColor(calendar.isDate(date, inSameDayAs: today) ||
                                             calendar.isDate(date, inSameDayAs: selectedDate) ?
                                             .white :
                                             .primary)
                            .clipShape(Circle())
                            .onTapGesture {
                                selectedDate = date
                            }
                    } else {
                        // Placeholder for empty cells
                        Color.clear
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .padding()
        }
        .background(appearance.currentScheme.secondary)
        .cornerRadius(16)
        .overlay( // Use overlay to add a rounded border
            RoundedRectangle(cornerRadius: 16)
                .stroke(appearance.currentScheme.calendarBorder, lineWidth: 2)
        )
    }

    private func weekDays() -> [Date?] {
        // Find the start of the week (Sunday)
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: today)?.start else {
            return []
        }

        // Create an array for the current week (Sunday to Saturday)
        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
        }
    }
    
    private func currentMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: today)
    }
}

#Preview {
    
    struct CalendarGridPreview: View {
        let previewAppearance = AppearanceSettings()
        @State private var selectedDate = Date()
        private let today = Date()
        

        var body: some View {
            CalendarGrid(selectedDate: $selectedDate)
                .environmentObject(previewAppearance)

        }
    }
    

    return CalendarGridPreview()
}
