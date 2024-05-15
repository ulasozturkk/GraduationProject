import Foundation

struct CreateMeetingDTO: Codable {
    let title: String
    let description: String
    let time: String
    let isOnline: Bool
    let meetingLink: String?
    let latitude: Double?
    let longitude: Double?
    let ownerID: String
    let invitedUsersIDList: [String]
}
