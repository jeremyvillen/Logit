import SwiftUI

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
        APIManager.shared.confirmEmail(email: email, code: confirmationCode) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    isConfirmed = true
                    navigationPath.append(.mainView) // ✅ Navigate to MainView
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
#Preview {
    ConfirmationView(email: "test@example.com", navigationPath: .constant([]))
}
