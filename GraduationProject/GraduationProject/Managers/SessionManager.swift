import Foundation

class SessionManager {
  static let shared = SessionManager()


  var currentServiceUser: User?
  private init() {}

  func setServiceUser(serviceUserResponse: AuthResponse) {
    self.currentServiceUser = User(userID: serviceUserResponse.data.email,
                                   email: serviceUserResponse.data.email,
                                   accessToken: serviceUserResponse.data.accessToken,
                                   tokenExpiration: serviceUserResponse.data.accessTokenExpiration)

  }
}
