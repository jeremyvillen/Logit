import Foundation
import SwiftUI

class EquipmentSettings: ObservableObject {
    @Published var equipmentList: [Equipment] = Equipment.defaultEquipment()
    
    // Convenience initializer (if needed)
    init(equipment: [Equipment] = Equipment.defaultEquipment()) {
        self.equipmentList = equipment // Corrected here
    }
}
