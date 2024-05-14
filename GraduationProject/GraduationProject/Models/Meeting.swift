import Foundation

struct Meeting: Codable {
  let meetingID, title, description, time: String
  let isOnline: Bool
  let meetingLink: String
  let latitude, longitude: Double
  let meetingMinutes, createdDate, updatedDate: String
  let reviewMean: Double
  let isDeleted: Bool
  let ownerID, chatRoomID: String
  let userMeetings: JSONNull?
  let attendeeUsersIDs, invitedUsersIDs: [String]?
  let meetingInvitations: JSONNull?
}
