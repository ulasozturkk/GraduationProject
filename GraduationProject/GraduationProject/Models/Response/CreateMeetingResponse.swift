import Foundation

struct CreateMeetingResponse: Codable {
    let data: DataClass
    let statusCode: Int
    let error: JSONNull?
  enum CodingKeys: String, CodingKey {
          case data
          case statusCode
          case error
      }
}

// MARK: - DataClass
struct DataClass: Codable {
    let meetingID, title, description, time: String
    let isOnline: Bool
    let meetingLink: String?
    let latitude, longitude: Double
    let createdDate, updatedDate: String
    let reviewMean: Int
    let isDeleted: Bool
    let ownerID, chatRoomID: String
    let userMeetings: JSONNull?
    let attendeeUsersIDs: [JSONAny]
    let invitedUsersIDs: [String]
    let meetingInvitations: JSONNull?
}
