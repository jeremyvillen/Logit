import SwiftUI
import SwiftData

struct EquipmentSettingsView: View {
    @Binding var isVisible: Bool
    @EnvironmentObject var equipmentList: EquipmentList // ObservableObject wrapping equipment data
    @EnvironmentObject var appearance: AppearanceSettings



    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation { isVisible = false }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .padding()
                }
                Spacer()
                Text("Equipment Settings")
                    .font(.title)
                Spacer()
            }

            List {
                ForEach(equipmentList.items.indices, id: \.self) { index in
                    HStack {
                        Text(equipmentList.items[index].name)
                        Spacer()
                        Toggle("Available", isOn: $equipmentList.items[index].isAvailable)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            .onChange(of: equipmentList.items[index].isAvailable) { newValue in
                                print("\(equipmentList.items[index].name) isAvailable: \(newValue)")
                            }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .background(Color(appearance.currentScheme.primary))
        }
        .padding()
    }
}

#Preview {
    EquipmentSettingsView(
        isVisible: .constant(true)
    )
    .environmentObject(EquipmentList.shared) // Inject the mock object here
    .environmentObject(AppearanceSettings())
}

class EquipmentList: ObservableObject {
    static let shared = EquipmentList()
    
    @Published var items: [Equipment]
    
    init(items: [Equipment] = Equipment.defaultEquipment()) {
        self.items = items
    }
    
    func updateAvailability(at index: Int, to newValue: Bool) {
            guard index >= 0 && index < items.count else { return }
            items[index].isAvailable = newValue
        }
    }

    

