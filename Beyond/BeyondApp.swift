import SwiftUI
import SwiftData
import Amplify
import AWSCognitoAuthPlugin

@main

struct BeyondApp: App {
    @StateObject private var appearanceSettings = AppearanceSettings()
    @StateObject var equipmentSettings = EquipmentSettings()
    @StateObject var equipmentList = EquipmentList()

    var container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Dataitem.self, Workouts.self, WeightEntry.self)
        } catch let error as SwiftDataError {
            print("SwiftData Error: \(error)")
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        } catch {
            fatalError("Unexpected error: \(error.localizedDescription)")
        }

        configureAmplify() // Initialize AWS Amplify
    }


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appearanceSettings)
                .modelContainer(container)
                .environmentObject(equipmentSettings)
                .environmentObject(EquipmentList.shared)
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin()) // Add Cognito Plugin
            try Amplify.configure()
            print("✅ Amplify successfully configured")
        } catch {
            print("⚠️ Failed to configure Amplify: \(error)")
        }
    }
}


