
import Foundation

struct Meeting : Identifiable {
  var id: String
  var isOnline: Bool
  var locaiton : Place?
  var time : Date
  var title : String
  var quests: [String]
  var price : Double
  var meetingLink: String?
}
// TODO: - ADD COLORS
