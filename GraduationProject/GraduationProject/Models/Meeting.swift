import Foundation

struct Meeting: Codable {
    let meetingID, title, description, time: String
    let isOnline: Bool
    let meetingLink: String?
    let latitude, longitude: Double
    let meetingMinutes: String?
    let createdDate, updatedDate: String
    let reviewMean: Int
    let isDeleted: Bool
    let ownerID, chatRoomID: String
    let userMeetings, meetingInvitations: String?
}
