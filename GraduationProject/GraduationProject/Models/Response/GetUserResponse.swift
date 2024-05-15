
import Foundation

struct GetUserResponse: Codable {
    var data: [UserDTO]
    let statusCode: Int
    let error: JSONNull?
}

// MARK: - Datum
struct UserDTO: Codable {
    let userID, email: String
}
