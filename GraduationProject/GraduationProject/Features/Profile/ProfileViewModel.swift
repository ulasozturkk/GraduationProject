
import Foundation

class ProfileViewModel: ObservableObject {
  @Published var userFriendsResponse: UsersFriendsResponse = .init(data: [], statusCode: 1, error: nil)
  @Published var isLoading : Bool = false
  @Published var friendMessage: String = ""

  private func fetchFriends(completion: @escaping (Result<UsersFriendsResponse, Error>)->Void) {
    let endpoint = Endpoint.getUsersFriends
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }
  func getUsersFriends(){
    self.isLoading = true
    DispatchQueue.global().asyncAfter(deadline: .now() + 2){
      DispatchQueue.main.async {
        self.fetchFriends { result in
          switch result {
          case .success(let res):
            self.userFriendsResponse = res
            self.isLoading = false
          case .failure(let err):
            print(err)
          }
        }
      }
      
    }
  }
  
  private func setFriendship(userID: String,requestUserID:String,completion: @escaping (Result<NoDataResponse,Error>)->Void ){
    let endpoint = Endpoint.sendFriendRequest(senderID: userID, receiverID: requestUserID)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }
  
  func sendFriendshipRequest(requestUserID:String){
    setFriendship(userID: SessionManager.shared.currentServiceUser!.userID, requestUserID: requestUserID) { result in
      switch result {
      case .success(let res):
        self.friendMessage = "Request sent"
      case .failure(let err):
        print(err)
      }
    }
  }
  }
