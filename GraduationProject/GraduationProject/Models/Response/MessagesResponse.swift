import Foundation

struct MessagesResponse: Codable {
  var data: [messagedto]
  let statusCode: Int?
  let error: JSONNull?
}

// MARK: - Datum

struct messagedto: Codable {
  let messageID: String
  let message, userID, userEmail: String
}
