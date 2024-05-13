
import Foundation

class SignUpViewModel: ObservableObject {
  @Published var Username: String = ""
  @Published var Email: String = ""
  @Published var Password: String = ""
  @Published var ConfirmPassword: String = ""
  @Published var errorMessage: String = ""
  @Published var changePage: Bool = false


  private func validateTextFields() -> Bool {
    if Username != "" && Email != "" && Password != "" && ConfirmPassword != "" {
      if Password == ConfirmPassword {
        return true
      } else {
        errorMessage = "Unmatched passwords"
        return false
      }
    } else {
      errorMessage = "fields can not be empty!"
      return false
    }
  }

  func signupwhelper() {
    let isvalidated = validateTextFields()
    if isvalidated {
      NetworkManager.shared.createUser(email: Email, password: Password) { result in
        switch result {
        case .success(let res):
          self.changePage = true
          print(res)
        case .failure(let err):
          self.errorMessage = err.localizedDescription
        }
      }
    }
  }
}
