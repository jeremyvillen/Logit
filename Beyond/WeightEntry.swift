import SwiftData
import Foundation

@Model

final class WeightEntry {
    @Attribute(.unique) var id: UUID
    var date: Date
    var weight: Double

    init(id: UUID = UUID(), date: Date, weight: Double) {
        self.id = id
        self.date = date
        self.weight = weight
    }
}
