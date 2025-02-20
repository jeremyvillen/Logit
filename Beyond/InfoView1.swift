//
//  InfoView1.swift
//  Beyond
//
//  Created by Star Andres on 30/10/2024.
//

import SwiftUI
import SwiftData

struct InfoView1: View {
    
    @Environment(\.modelContext) private var context
    @EnvironmentObject var appearance: AppearanceSettings
    
    @State private var showConfirmationView = false
    @State private var email = ""
    @State private var pass = ""
    @State private var error = ""
    @State private var passConfirm = ""
    @Binding var navigationPath: [ContentView.Destination]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                VStack {
                    Text("Progress: 10/10")
                        .font(.custom("exo", size: 15))
                        .foregroundColor(Color.white)
                        .padding(.top, 1150)
                    
                    Spacer()
                    
                    Text("Create Your Account")
                        .foregroundColor(Color.black)
                        .font(.custom("exo", size: 30))
                        .padding(.bottom, 100)
                    
                    TextField("", text: $email, prompt: Text("Email")
                        .foregroundColor(.gray))
                    .padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    
                    SecureField("Password", text: $passConfirm, prompt: Text("Password")
                        .foregroundColor(.gray))
                    .padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    
                    SecureField("", text: $pass, prompt: Text("Confirm Password")
                        .foregroundColor(.gray))
                    .padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    
                    if !error.isEmpty {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button("Start          ") {
                        if validateForm() {
                            saveCredentials()
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1))
                }
                .padding(.bottom, 1450)
            }
            .onAppear {
                checkPersistentLogin()
            }
            .navigationDestination(isPresented: $showConfirmationView) {
                ConfirmationView(email: email, navigationPath: $navigationPath)
            }
        }
    }
    func validateForm() -> Bool {
        if email.isEmpty || pass.isEmpty || passConfirm.isEmpty {
            error = "All fields are required"
            return false
        } else if pass != passConfirm {
            error = "Passwords do not match"
            return false
        } else if !email.contains("@") {
            error = "Invalid email format"
            return false
        }
        error = ""
        return true
    }
    
    func saveCredentials() {
        APIManager.shared.signup(email: email, password: pass) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    showConfirmationView = true // Navigate to confirmation screen
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
    func checkPersistentLogin() {
        if let savedEmail = KeychainManager.retrieve("userEmail"),
           let savedPassword = KeychainManager.retrieve("userPassword") {
            APIManager.shared.login(email: savedEmail, password: savedPassword) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let token):
                        print("Logged in with token: \(token)")
                        navigationPath.append(.mainView)
                    case .failure(let error):
                        print("Failed to auto-login: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            print("No saved credentials, remain on login screen")
        }
    }
}

#Preview {
    InfoView1(navigationPath:.constant([]))
        .environmentObject(AppearanceSettings())
}
