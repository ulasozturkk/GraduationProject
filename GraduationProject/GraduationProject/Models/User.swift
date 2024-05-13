import Foundation

struct User {
  var userID: String
  var email: String
  var userName: String?
  var nickName: String?
  var passwordHash : String?
  var lastLogin : Date?
  var isDeleted: Bool?
  var accessToken : String
  var tokenExpiration: String
}
