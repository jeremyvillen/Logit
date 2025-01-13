//
//  Dataitem.swift
//  Beyond
//
//  Created by Star Andres on 06/11/2024.
//

import Foundation
import SwiftData


@Model
class Dataitem:Identifiable {
    
    @Attribute(.unique) var email: String
    @Attribute(.allowsCloudEncryption)var password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
