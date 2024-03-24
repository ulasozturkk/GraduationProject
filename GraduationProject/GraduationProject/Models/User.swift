
import Foundation

struct User:Identifiable  {  //Codable
  var id: String
  var username : String
  var email : String
  var password: String
  var friends : [UUID]?
  var meetings: [Meeting]?
  var meetingInvites: [Meeting]?
  var pastMeetings: [Meeting]?
  var favPlaces: [Place]?
  
  
}
