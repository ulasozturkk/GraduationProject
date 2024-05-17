import Foundation

struct FriendshipRequestsResponse: Codable {
    let data: [Frienddto]
    let statusCode: Int
    let error: JSONNull?
}

// MARK: - Datum
struct Frienddto: Codable {
    let id, senderID, receiverID: String
}
