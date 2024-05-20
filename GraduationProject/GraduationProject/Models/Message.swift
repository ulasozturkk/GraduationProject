import Foundation

struct Message: Codable {
    let messageID: String?
    let message: String
    let timeStamp: String?
    let chatRoomID: String?
    let userID: String
    let userEmail: String
}
