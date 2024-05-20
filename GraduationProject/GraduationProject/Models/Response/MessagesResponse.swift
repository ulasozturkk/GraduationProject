import Foundation
struct MessagesResponse: Codable {
    let data: [messagedto]
    let statusCode: Int
    let error: JSONNull?
}

// MARK: - Datum
struct messagedto: Codable {
    let message, userID, userEmail: String
}
