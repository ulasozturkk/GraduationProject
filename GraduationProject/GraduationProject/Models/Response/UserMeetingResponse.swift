
import Foundation


struct UserMeetingResponse: Codable {
    let data: [Meeting]
    let statusCode: Int
    let error: JSONNull?
}



