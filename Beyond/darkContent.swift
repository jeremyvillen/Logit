//
//  ContentView.swift
//  Beyond
//
//  Created by Star Andres on 30/10/2024.
//

import SwiftUI

struct darkContent: View {
    @State private var name = ""
    @State private var pass = ""
    @State private var error = ""
    @State private var showLogin = false
    @State private var passConfirm = ""
    @State private var navigateToInfo = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                Image("test")
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
                    
                VStack {

                    Image("darkbeyond")
                        .resizable()
                        .frame(width: 300.0, height: 300.0)
                        .cornerRadius(50)
                        .aspectRatio(contentMode: .fill)
                        .padding(.bottom, 50)
                        .ignoresSafeArea()
                        .shadow(color: .white.opacity(0.2), radius: 10, x:0 , y: 0)
 
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
                    
//                    NavigationLink(destination: InfoView1(), isActive: $navigateToInfo) {
//                        EmptyView()
//                    }
                    
                    Button("Start          ") {
                            navigateToInfo = true  // Trigger navigation
                    }
                    .padding(.all)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(30)
                    .font(.custom("Exo", size: 20))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
//                    .frame(width: 100.0, height: 20.0)
                    
                    Button("Login                       ") {
                        showLogin = true
//                        if name.isEmpty {
//                            error = "Please provide username"
//                        } else if pass.isEmpty {
//                            error = "Please provide password"
//                        } else if passConfirm.isEmpty {
//                            error = "Please confirm your password"
//                        } else if pass != passConfirm {
//                            error = "Passwords do not match"
//                        } else {
//                            error = ""
//                            // Add your account creation logic here
//                        }
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(30)
                    .font(.custom("Exo", size: 20))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                    
                    if !error.isEmpty {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
//                    Spacer()
//                        .frame(height:1300)
                }
                .padding()

            }
        }
        
    }
}

#Preview {
    darkContent()
}
