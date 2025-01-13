import Foundation
import SwiftData


class Equipment: Identifiable, ObservableObject, Codable, Hashable, CustomStringConvertible {
    let id: UUID // Unique identifier for each equipment
    let name: String // Name of the equipment
    @Published var isAvailable: Bool // Track availability status
    
    init(name: String, isAvailable: Bool = false) {
        self.id = UUID()
        self.name = name
        self.isAvailable = isAvailable
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case isAvailable
    }

    // Decoding from a decoder
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let isAvailableValue = try container.decode(Bool.self, forKey: .isAvailable)
        self.isAvailable = isAvailableValue
    }

    // Encoding to an encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isAvailable, forKey: .isAvailable)
    }
    
    static func == (lhs: Equipment, rhs: Equipment) -> Bool {
            return lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
    // Default equipment list
    static func defaultEquipment() -> [Equipment] {
        return [
            Equipment(name: "Dumbbells"),
            Equipment(name: "Cables"),
            Equipment(name: "Pull-Up Bar"),
            Equipment(name: "Smith Machine"),
            Equipment(name: "Dip Bar"),
            Equipment(name: "Planche"),
            Equipment(name: "Barbells"),
            Equipment(name: "Resistance Bands"),
            Equipment(name: "Treadmill"),
            Equipment(name: "Stationary Bike"),
            Equipment(name: "Kettlebells"),
            Equipment(name: "Medicine Ball"),
            Equipment(name: "Machines")
        ]
    }
    var description: String {
            return "Equipment(name: \(name), isAvailable: \(isAvailable))"
        }
}
