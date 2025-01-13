//
//  ContentView.swift
//  Beyond
//
//  Created by Star Andres on 30/10/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @EnvironmentObject var appearance: AppearanceSettings
    @Environment(\.modelContext) private var context
    @State private var navigationPath: [Destination] = []
    @Query private var items: [Dataitem]
    @State private var name = ""
    @State private var pass = ""
    @State private var error = ""
    @State private var showLogin = false
    @State private var passConfirm = ""
    @State private var navigateToInfo = false
    
    enum Destination: Hashable {
        case infoView1
        case mainView
        case question1
//        case question2
       }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.white
                
                VStack {  
                    
                    Image("newbeyondlogo")
                        .resizable()
                        .frame(width: 300.0, height: 300.0)
                        .cornerRadius(50)
                        .aspectRatio(contentMode: .fill)
                        .padding(.bottom, 50)
                        .ignoresSafeArea()
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)

                    
                    Button("Start          ") {
                        navigationPath.append(.question1)  // Trigger navigation
                    }
                    .padding(.all)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .font(.custom("Exo", size: 20))
                    .shadow(color: .white.opacity(0.2), radius: 10, x: 0, y: 0)
                    //                    .frame(width: 100.0, height: 20.0)
                    
                    Button("Login                       ") {
                        showLogin = true
                        //                        addItem()
                    }
                    
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(30)
                    .font(.custom("Exo", size: 20))
                    .shadow(color: .white.opacity(0.2), radius: 10, x: 0, y: 0)
                    
                    //                    List {
                    //                        ForEach(items) {
                    //                            item in Text(item.name)
                    //                        }
                    //                    }
                    
                    
                    if showLogin {
                        TextField("Username", text: $name)
                            .padding()
                            .frame(width: 300.0, height: 50.0)
                            .background(Color.black)
                            .cornerRadius(30)
                        SecureField("Confirm Password", text: $passConfirm)
                            .padding(.bottom, 100)
                            .frame(width: 300.0, height: 50.0)
                            .background(Color.black)
                            .foregroundStyle(Color.gray)
                            .cornerRadius(30)
                    }
                    
                    if !error.isEmpty {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding()
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case.question1:
                    Question1(navigationPath: $navigationPath)
                case.infoView1:
                    InfoView1(navigationPath: $navigationPath)
                case.mainView:
                     MainView()
                }
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Dataitem.self)
        .environmentObject(AppearanceSettings())
}
