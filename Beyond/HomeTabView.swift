import SwiftUI
import SwiftData

struct HomeTabView: View {
    

    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss

    @Binding var selectedDate: Date
    @Binding var workouts: [Workouts]
    @Binding var workoutsForDates: [Date: [Workouts]]
    @Binding var isScheduleWorkoutPresented: Bool
    @Binding var selectedWorkoutDate: Date?
    @Binding var isSettingsVisible: Bool

    @State private var isLoggedOut = false // Track logout state
    @State private var scrollOffset: CGFloat = 0
    @State private var isTopBarVisible: Bool = true
    @State private var isAppearanceVisible: Bool = false
    @State private var isProfileVisible: Bool = false
    @State private var isNotifsVisible: Bool = false
    @State private var isWidgetsVisible: Bool = false
    @State private var isEquipmentVisible: Bool = false
    

    @EnvironmentObject var equipmentList:  EquipmentList
    @EnvironmentObject var appearance: AppearanceSettings

    

    var body: some View {
        ZStack {
            appearance.currentScheme.primary
            ZStack(alignment: .top) {
                ScrollView {
                    GeometryReader { geometry in
                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
                    }
                    .frame(height: 0) // Invisible frame to track scrolling
                    
                    VStack(alignment: .leading, spacing: 20) {
                        if isTopBarVisible {
                            Spacer().frame(height: 60) // Spacer when top bar is visible
                        }
// MARK: - Calendar with Schedules Workouts

                        // Calendar Section
                        CalendarWithWorkoutsView(
                            selectedDate: $selectedDate,
                            availableWorkouts: workouts,
                            workoutsForDates: $workoutsForDates,
                            onAddWorkoutToDate: { date, workout in
                                if workoutsForDates[date] == nil {
                                    workoutsForDates[date] = []
                                }
                                workoutsForDates[date]?.append(workout)
                            }
                        )
                        .padding()
                        
// MARK: - Widgets

                        HStack(spacing: 16) {
                            WaterWidget(title: "Water", color: .blue)
                        }
                        .padding(.horizontal)
                        
                    }
                    .background(appearance.currentScheme.primary)
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    withAnimation {
                        isTopBarVisible = value > -10 // Adjust based on your preferred threshold
                        scrollOffset = value
                    }
                }
// MARK: - Top Bar / Settings

                // Top Bar
                ZStack {
                    appearance.currentScheme.primary
                        .frame(height: 60)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
                        .opacity(max(CGFloat(0), min(CGFloat(1), CGFloat(1) + scrollOffset / 100)))                        .offset(y: max(0, scrollOffset / 10)) // Smooth upward movement
                    HStack {
                        Text("Progress Buddy")
                            .font(.headline)
                            .foregroundColor(appearance.currentScheme.text)
                            .padding(.leading, 16)
                        Spacer()
                        Button(action: {
                            print("Settings tapped")
                            withAnimation {
                                isSettingsVisible.toggle()
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .frame(width: 24, height: 18)
                                .foregroundColor(appearance.currentScheme.text)
                        }
                        .padding(.trailing, 16)
                    }
                }
                .transition(.move(edge: .top))
                .zIndex(1)
            }
// MARK: - Settings Tab

            // Sliding Settings View
            if isSettingsVisible {
                ZStack {
                    // Background Overlay
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isSettingsVisible.toggle()
                            }
                        }
                    
                    // Settings Panel
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Settings")
                                .font(.title)
                                .padding(.bottom, 16)
                            
                            Divider()
                            
                            Button("Profile") {
                                print("Account tapped")
                                withAnimation {
                                    isProfileVisible = true
                                    isSettingsVisible = false
                                }
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            
                            Button("Equipment") {
                                print("Equipment tapped")
                                withAnimation {
                                    isEquipmentVisible = true
                                    isSettingsVisible = false
                                }
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            
                            Button("Appearance") {
                                withAnimation {
                                    isAppearanceVisible = true
                                    isSettingsVisible = false
                                }
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            
                            Button("Notifications") {
                                print("Notifications tapped")
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            
                            Button("Widgets") {
                                print("Widgets tapped")
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button("Logout") {
                                print("Logoutt tapped")
                                handleLogout()
                            }
                            .font(.headline)
                            .foregroundColor(.red)
                            
                        }
                        .padding(24)
                        .frame(width: 300)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .transition(.move(edge: .trailing))
                .zIndex(2)
            }
            
// MARK: - Profile Settings View

            if isProfileVisible {
                
                ZStack {
                    // Dimmed background that dismisses on tap
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isProfileVisible = false
                            }
                        }
                    ProfileSettingsView()
                        .frame(width: UIScreen.main.bounds.width * 0.7) // Takes up 70% of the screen width
                        .background(Color.white)
                        .cornerRadius(0)
                        .shadow(radius: 10)
                        .transition(.move(edge: .trailing))
                        .zIndex(3)
                    
                }
            }
            
// MARK: - Equipment Settings View
            if isEquipmentVisible {
                ZStack {
                    // Dimmed background to dismiss when tapped
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isEquipmentVisible = false
                            }
                        }
                    
                    // Equipment Settings View
                    EquipmentSettingsView(isVisible: $isEquipmentVisible)
                        .padding(.top, 30)
                        .transition(.move(edge: .trailing))
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // Full screen
                        .background(Color.white)
                        .cornerRadius(0)
                        .shadow(radius: 5)
                        .transition(.move(edge: .trailing)) // Slide-in effect
                        .zIndex(3)
                }
                .zIndex(3)
            }
            
            

            
// MARK: - Appearance/Theme Settings View

            if isAppearanceVisible {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isAppearanceVisible = false
                            }
                        }

                    AppearanceSettingsView()
                        .frame(maxWidth: 300, maxHeight: 400)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.move(edge: .trailing))
                        .environmentObject(appearance)
                }
                .zIndex(3)
            }
            VStack {
                Spacer()
                Button("Start") {
                    print("Start button pressed.")
                }
                .padding()
                .frame(width: 100.0, height: 100.0)
                .background(appearance.currentScheme.button)
                .foregroundColor(appearance.currentScheme.buttonText)
                .cornerRadius(50)
                .font(.custom("Exo", size: 20))
                .shadow(color: appearance.currentScheme.shadow.opacity(0.9), radius: 10)
                .opacity(isSettingsVisible ? 0 : 1) // Adjust opacity based on isSettingsVisible
                .animation(.easeInOut(duration: 0.3), value: isSettingsVisible) // Smooth fade animation
            }
            .padding(.bottom, 30)
        }
    }
    func handleLogout() {
        // Clear credentials from Keychain
        if let savedEmail = KeychainManager.retrieve("userEmail"),
           let savedPassword = KeychainManager.retrieve("userPassword") {
            print("Before logout:")
            print("userEmail: \(savedEmail)")
            print("userPassword: \(savedPassword)")
        }
        
        KeychainManager.delete("userEmail")
        KeychainManager.delete("userPassword")

        // Print values after deletion (should be empty)
        print("After logout:")
        if let savedEmail = KeychainManager.retrieve("userEmail") {
            print("userEmail: \(savedEmail)")
        } else {
            print("userEmail: nil")
        }

        if let savedPassword = KeychainManager.retrieve("userPassword") {
            print("userPassword: \(savedPassword)")
        } else {
            print("userPassword: nil")
        }

        // Dismiss the current view (returning to login view)
        withAnimation {
            isLoggedOut = true
            dismiss() // This will dismiss the current view
        }

        print("User logged out successfully.")
    }
}

// Preference key to track the scroll offset
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    HomeTabView(
        selectedDate: .constant(Date()),
        workouts: .constant([]),
        workoutsForDates: .constant([:]),
        isScheduleWorkoutPresented: .constant(false),
        selectedWorkoutDate: .constant(nil),
        isSettingsVisible: .constant(false)
    )
    .environmentObject(AppearanceSettings())


}
