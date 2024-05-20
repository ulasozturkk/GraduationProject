
import Foundation


class MeetingChatViewModel : ObservableObject {
  @Published var messages : MessagesResponse = MessagesResponse(data: [], statusCode: 0, error: nil)
  
  private func getAllMessages(meetingID: String,message:String,userID:String,email:String,completion: @escaping (Result<MessagesResponse,Error>)->Void){
    let endpoint = Endpoint.addMessage(meetingID: meetingID, message: message, userID: userID,email: email)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }
  
  func getMessages(meetingID: String,message:String,userID:String,email:String){
      DispatchQueue.global().asyncAfter(deadline: .now() + 1){
        DispatchQueue.main.async {
          self.getAllMessages(meetingID: meetingID, message: message, userID: userID, email: email) { result in
            switch result {
            case .success(let res):
              self.messages = res
            case .failure(let err):
              print(err)
            }
          }
        }
      }
  }
}
