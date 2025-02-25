import Foundation

struct CognitoConfig {
    static let issuer = "https://cognito-idp.us-west-1.amazonaws.com/us-west-1_kTLusi9j6"
    static let clientID = "47m786bftqpqjo6662k35n5i61"
    static let redirectURI = URL(string: "yourapp://callback")!
    static let logoutURI = URL(string: "yourapp://signout")!
}
