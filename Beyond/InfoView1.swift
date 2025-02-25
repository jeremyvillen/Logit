
import SwiftUI
import SwiftData
import Amplify

struct InfoView1: View {
    
    @Environment(\.modelContext) private var context
    @EnvironmentObject var appearance: AppearanceSettings
    
    @State private var showConfirmationView = false
    @State private var email = ""
    @State private var pass = ""
    @State private var error = ""
    @State private var passConfirm = ""
    @Binding var navigationPath: [ContentView.Destination]
    @State private var confirmationCode = "" // ✅ Stores the verification code
    @State private var isVerificationNeeded = false // ✅ Control
    
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
                    
                    Button("Sign Up          ") {
                        if validateForm() {
                            saveCredentials()
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    if isVerificationNeeded {
                        TextField("Enter Confirmation Code", text: $confirmationCode)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.white)
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                            .keyboardType(.numberPad)
                        
                        Button("Confirm") {
                            confirmSignUp()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom, 1450)
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
        Task {
            do {
                let signUpResult = try await Amplify.Auth.signUp(
                    username: email,
                    password: pass,
                    options: .init(userAttributes: [AuthUserAttribute(.email, value: email)])
                )
                
                DispatchQueue.main.async {
                    if signUpResult.isSignUpComplete {
                        navigationPath.append(.mainView) // ✅ If sign-up is complete, go to main app
                    } else {
                        error = "Check your email for the verification code."
                        isVerificationNeeded = true // ✅ Show the confirmation code input
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
    func confirmSignUp() {
        Task {
            do {
                let confirmResult = try await Amplify.Auth.confirmSignUp(for: email, confirmationCode: confirmationCode)
                
                DispatchQueue.main.async {
                    if confirmResult.isSignUpComplete {
                        navigationPath.append(.mainView) // ✅ Navigate to main app upon success
                    } else {
                        error = "Verification failed. Try again."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
}

#Preview {
    InfoView1(navigationPath:.constant([]))
        .environmentObject(AppearanceSettings())
}
