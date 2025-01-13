
import Foundation
import SwiftUI
import SwiftData
struct AppearanceSettingsView: View {
    @EnvironmentObject var appearance: AppearanceSettings

    var body: some View {
        List {
            ForEach(appearance.schemes, id: \.name) { scheme in
                Button(action: {
                    appearance.changeScheme(to: scheme)
                }) {
                    HStack {
                        Text(scheme.name)
                        Spacer()
                        if appearance.currentScheme.name == scheme.name {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                }
                .foregroundColor(.black)
            }
        }
        .background(appearance.currentScheme.background)
        .navigationTitle("Appearance Settings")
    }
}
#Preview {
    // Create a mock instance of AppearanceSettings for preview
    let previewAppearance = AppearanceSettings()

    // Use the environment object in the preview
    AppearanceSettingsView()
        .environmentObject(previewAppearance)
}
