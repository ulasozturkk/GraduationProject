import FirebaseAuth
import Foundation

struct AuthService {
  func signUpWithEmail(email: String, password: String,username:String) {
    let auth = Auth.auth()
    auth.createUser(withEmail: email, password: password) { _, error in
      if error != nil {
        print(error!.localizedDescription)
      }
      
    }
    FirebaseService.shared.AddUser(username: username, password: password, email: email)
  }

  func signInWithEmail(email: String, password: String) {
    let auth = Auth.auth()
    auth.signIn(withEmail: email, password: password) { _, error in
      if error != nil {
        print(error?.localizedDescription)
      }
      
    }
  }
  
  func signOut() {
    let auth = Auth.auth()
    do {
      try auth.signOut()
    } catch {
      print("signout error")
    }
  }
  
  func deleteAccount() {
    let user = Auth.auth().currentUser
    
    user?.delete(completion: { error in
      if let error = error {
        print("asdf--- \(error.localizedDescription)")
        return
      }
      print("silindi")
    })
    
  }
}
