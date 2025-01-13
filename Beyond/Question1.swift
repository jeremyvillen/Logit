//
//  Question1.swift
//  Beyond
//
//  Created by Star Andres on 08/11/2024.
//

import SwiftUI
import SwiftData

struct Question1: View {
    @Binding var navigationPath: [ContentView.Destination]
    @Environment(\.modelContext) private var context
    @State private var fitnessGoal = ""
    
    let goals = ["Lose Weight", "Build Muscle", "Get Stronger", "Increase Stamina", "Improve Flexibility"]
    
    let goalIcons: [String: String] = [
        "Lose Weight": "chevron.down.2",
        "Build Muscle": "dumbbell", "Get Stronger":"figure.strengthtraining.traditional",
        "Increase Stamina": "gauge.with.needle.fill",
        "Improve Flexibility": "figure.strengthtraining.functional"]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 10) {
                ProgressView(currentStep:1, totalSteps: 10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)
                    .padding()
                    .font(.custom("exo", size: 15))
                Spacer()
                Text("What's your fitness goal?")
                    .foregroundColor(Color.white)
                    .font(.custom("exo", size: 30))
                Text("Choose one")
                    .foregroundColor(Color.gray)
                    .font(.custom("exo", size: 15))
                Spacer()
                ForEach(goals, id: \.self) { goal in
                    HStack {
                        if let iconName = goalIcons[goal] {
                            Image(systemName:(iconName))
                                .resizable()
                                .foregroundColor(fitnessGoal == goal ? .white : .gray)                  .frame(width: 40, height: 40)
                                .padding(.trailing, 10)
                        }
                        
                        Text(goal)
                            .foregroundColor(Color.white)
                            .font(.custom("exo", size: 20))
                        
                        Spacer()
                        
                        // Circle to indicate selection
                        if fitnessGoal == goal {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 20, height: 20)
                            
                        } else {
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .onTapGesture {
                        fitnessGoal = goal
                    }
                    
                }
                Spacer()
                if !fitnessGoal.isEmpty {
                    Button(action: {
                        navigationPath.append(.infoView1)
                    }) {
                        Text("Continue")
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 200.0, height: 60.0)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .transition(.opacity)
                    .animation(.easeInOut, value: fitnessGoal)
                }
            }
        }
    }
}

#Preview {
    Question1(navigationPath: .constant([]))
}
