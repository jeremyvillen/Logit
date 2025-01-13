import SwiftUI

struct ProgressView: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        Text("Progress \(currentStep)/\(totalSteps)")
            .foregroundColor(.white)
            .font(.custom("exo", size: 20))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
    }
}

#Preview {
    ProgressView(currentStep: 1, totalSteps: 10)
}
