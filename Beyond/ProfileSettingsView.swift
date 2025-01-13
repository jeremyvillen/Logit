//
//  ProfileSettingsView.swift
//  Beyond
//
//  Created by Jeremy Villeneuve on 12/7/24.
//

import SwiftUI
import SwiftData

struct ProfileSettingsView: View {
    @Query private var dataItems: [Dataitem]

    var body: some View {
        ZStack {
            VStack {
                if let firstUser = dataItems.first {
                    VStack {
                        Text("User Email: \(firstUser.email)")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Password: \(firstUser.password)") // Avoid displaying passwords
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding()
                } else {
                    Text("No user data found")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    ProfileSettingsView()
}
