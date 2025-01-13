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

    @State private var email = ""
    @State private var pass = ""
    @State private var error = ""
    @State private var passConfirm = ""
    @State private var navigateToMain = false
    @Binding var navigationPath: [ContentView.Destination]
    
    enum Destination: Hashable {
        case mainView
    }
    
    var body: some View {
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
                        navigationPath.append(.mainView)
                    }
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
            .padding(.bottom, 1450)
        }
        .onAppear {
            checkPersistentLogin()
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
        let user = Dataitem(email: email, password: pass)
        
        do {
            // Save to SwiftData context@
            try context.insert(user)
            try context.save() // Commit the changes to the persistent store
            
            // Save credentials to Keychain
            KeychainManager.save("userEmail", value: email)
            KeychainManager.save("userPassword", value: pass)
            
            print("User credentials saved successfully")
        } catch {
            print("Error saving credentials: \(error.localizedDescription)")
        }
    }
    
    func checkPersistentLogin() {
        if let savedEmail = KeychainManager.retrieve("userEmail"),
           let savedPassword = KeychainManager.retrieve("userPassword") {
            print("Auto-logged in with saved credentials")
            email = savedEmail
            pass = savedPassword
            navigationPath.append(.mainView) // Navigate to the main view
        } else {
            print("No saved credentials, remain on login screen")
        }
    }
}

#Preview {
    InfoView1(navigationPath:.constant([]))
        .environmentObject(AppearanceSettings())
}
