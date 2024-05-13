
import Foundation

class SignInViewModel : ObservableObject{
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var errorMessage : String = ""
  @Published var changePage : Bool = false
  
  func signInWHelper(){
    let validate = validateTextfields(email: email, password: password)
    if validate == true {
      NetworkManager.shared.signInUser(email: email, password: password) { result in
        switch result {
        case .success(let response):
          SessionManager.shared.setServiceUser(serviceUserResponse: response)
          self.changePage = true
          
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          
        }
      }
    }
  }
  
  private func validateTextfields(email:String,password:String) -> Bool{
    if (email == "" || password == "") {
      self.errorMessage = "Fields can not be empty!"
      return false
    }else {
      return true
    }
  }
}
