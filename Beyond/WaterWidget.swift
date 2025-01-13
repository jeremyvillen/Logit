//
//  WaterWidget.swift
//  Beyond
//
//  Created by Jeremy Villeneuve on 12/3/24.
//

import SwiftUI

struct WaterWidget: View {
    let title: String
    let color: Color
    let goal: Double = 124.0
    
    @State private var waterConsumed: Double = 0.0
    @State private var lastUpdated: Date = Date()
    
    @EnvironmentObject var appearance: AppearanceSettings


    var progress: Double {
        waterConsumed / goal
    }

    
    var body: some View {
        ZStack {
                // Outer Progress Bar
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(
                    style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round)
                )
                .foregroundColor(appearance.currentScheme.progressBar.opacity(0.3))
                .frame(width: 120, height: 120)

            RoundedRectangle(cornerRadius: 20)
                .trim(from: 0, to: progress)
                .stroke(appearance.currentScheme.progressBar, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90)) // Starts at top
                .frame(width: 120, height: 120)

                // Buttons for Adding Water
            VStack {
                HStack {
                        Text(title)
                            .font(.custom("Exo", size: 15))
                            .foregroundColor(appearance.currentScheme.widgetText)
                            .padding(.leading, 12)



                        Button(action: {
                            // Action for the settings button
                            print("Settings button tapped")
                        }) {
                            Image(systemName: "gearshape")
                                .resizable()
                                .frame(width: 20, height: 20) // Adjust size as needed
                                .foregroundColor(appearance.currentScheme.widgetText)
                        }
                    }
                
                Text("\(Int(progress * 100))%")
                    .font(.custom("Exo", size: 20))
                    .bold()
                    .foregroundColor(appearance.currentScheme.widgetText)
                
                Text("\(waterConsumed, specifier: "%.1f") / \(goal) cups")
                    .font(.caption)
                    .foregroundColor(appearance.currentScheme.widgetText)
                
                HStack(spacing: 10) {
                    ForEach(cupSizes, id: \.amount) { cup in
                        VStack {
                            Image(systemName: cup.symbolName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundColor(appearance.currentScheme.widgetText)
                                .onTapGesture {
                                    addWater(amount: cup.amount)
                                }
                                .gesture(
                                    LongPressGesture(minimumDuration: 0.5)
                                        .onEnded { _ in
                                            removeWater(amount: cup.amount)
                                        }
                                )
                        }
                    }
                }
                .padding(.top, 10)
            }
            .frame(width: 110, height: 110)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(appearance.currentScheme.primary)
                    .shadow(radius: 5)
            )
        }
        .onAppear(perform: resetIfNewDay)
    }

                    // Function to Add Water
    private func addWater(amount: Double) {
        resetIfNewDay()
        withAnimation {
            waterConsumed += amount
        }
    }
    
    private func removeWater(amount: Double) {
        resetIfNewDay()
        withAnimation {
            waterConsumed = max(0, waterConsumed - amount) // Prevents negative water consumption
        }
    }

                    // Reset Water Progress If a New Day
    private func resetIfNewDay() {
        let calendar = Calendar.current
        if !calendar.isDateInToday(lastUpdated) {
            waterConsumed = 0.0
            lastUpdated = Date()
        }
    }

                    // Cup Sizes with Corresponding SF Symbols
    private let cupSizes: [CupSize] = [
        CupSize(amount: 8, symbolName: "cup.and.saucer"),
        CupSize(amount: 12, symbolName: "drop"),
        CupSize(amount: 20, symbolName: "waterbottle"),
        CupSize(amount: 128, symbolName: "drop.circle")
    ]
}

    struct CupSize {
        let amount: Double
        let symbolName: String
    }

#Preview {
    let previewAppearance = AppearanceSettings()
    WaterWidget(title: "water", color: Color.black)
        .environmentObject(previewAppearance)

}
