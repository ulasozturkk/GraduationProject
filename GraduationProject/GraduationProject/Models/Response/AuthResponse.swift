import Foundation

struct AuthResponse: Codable {
    let data: UserDataInfo
    let statusCode: Int
    let error: String?

    struct UserDataInfo: Codable {
        let userID: String
        let email: String
        let accessToken: String
        let accessTokenExpiration: String
    }

    
}
