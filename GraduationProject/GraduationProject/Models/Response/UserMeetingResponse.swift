
import Foundation


struct UserMeetingResponse: Codable {
    var data: [Meeting]
    let statusCode: Int
    let error: JSONNull?
}



