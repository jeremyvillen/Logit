import SwiftUI
import Amplify

struct ConfirmationView: View {
    @State private var confirmationCode = ""
    let email: String
    @State private var errorMessage = ""
    @State private var isConfirmed = false
    @Environment(\.dismiss) private var dismiss
    @Binding var navigationPath: [ContentView.Destination] // ✅ Use NavigationPath to push MainView

    var body: some View {
        VStack {
            Text("Enter Confirmation Code")
                .font(.title)
                .padding()

            TextField("Code", text: $confirmationCode)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .keyboardType(.numberPad)

            Button("Confirm Email") {
                confirmUserEmail()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }

    func confirmUserEmail() {
        Task {
            do {
                let result = try await Amplify.Auth.confirmSignUp(for: email, confirmationCode: confirmationCode)
                DispatchQueue.main.async {
                    if result.isSignUpComplete {
                        navigationPath.append(.mainView) // ✅ Navigate to MainView
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
#Preview {
    ConfirmationView(email: "test@example.com", navigationPath: .constant([]))
}
