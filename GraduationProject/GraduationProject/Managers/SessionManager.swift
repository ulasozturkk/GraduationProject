import Foundation

class SessionManager {
  static let shared = SessionManager()


  var currentServiceUser: User?
  private init() {}

  func setServiceUser(serviceUserResponse: AuthResponse) {
    self.currentServiceUser?.email = serviceUserResponse.data.email
    self.currentServiceUser?.userID = serviceUserResponse.data.userID
    self.currentServiceUser?.accessToken = serviceUserResponse.data.accessToken
    self.currentServiceUser?.tokenExpiration = serviceUserResponse.data.accessTokenExpiration
  }
}
