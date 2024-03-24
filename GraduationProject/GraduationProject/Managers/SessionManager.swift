

import Foundation
import FirebaseAuth

class SessionManager {
  static let shared = SessionManager()

  var currentUser: User?
  private init() {}
  func setUser(user:User) {
      self.currentUser = user
  }
}
