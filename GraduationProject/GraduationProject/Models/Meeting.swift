import Foundation

struct Meeting: Codable,Equatable {
  let meetingID, title, description, time: String
  let isOnline: Bool
  let meetingLink: String
  let latitude, longitude: Double
  let createdDate, updatedDate: String
  let reviewMean: Double
  let isDeleted: Bool
  let ownerID, chatRoomID: String
  let userMeetings: JSONNull?
  let attendeeUsersIDs, invitedUsersIDs: [String]?
  let meetingInvitations: JSONNull?
  enum CodingKeys: String, CodingKey {
    case meetingID
    case title
    case description
    case time
    case isOnline
    case meetingLink
    case latitude
    case longitude

    case createdDate
    case updatedDate
    case reviewMean
    case isDeleted
    case ownerID
    case chatRoomID
    case userMeetings
    case attendeeUsersIDs
    case invitedUsersIDs
    case meetingInvitations
  }
}
