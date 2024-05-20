
import Foundation

class MeetingChatViewModel: ObservableObject {
  @Published var messages: MessagesResponse = .init(data: [], statusCode: 0, error: nil)
  @Published var isLoading: Bool = false
  let webSocketManager = WebsocketManager()

  private func sendMessage(meetingID: String, message: String, userID: String, email: String, completion: @escaping (Result<NoDataResponse, Error>)->Void) {
    let endpoint = Endpoint.addMessage(meetingID: meetingID, message: message, userID: userID, email: email)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }

  private func getAllMessages(meetingID: String, completion: @escaping (Result<MessagesResponse, Error>)->Void) {
    let endpoint = Endpoint.getMessages(meetingID: meetingID)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }

  func getMessages(meetingID: String) {
    isLoading = true
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
      DispatchQueue.main.async {
        self.getAllMessages(meetingID: meetingID) { result in

          switch result {
          case .success(let res):
            self.isLoading = false
            self.messages = res
          case .failure(let err):
            self.isLoading = false
            print(err)
          }
        }
      }
    }
  }

  func sendMessage(meetingID: String, message: String, userID: String, email: String) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {

      self.webSocketManager.sendMessage(userID: userID, userEmail: email, text: message)
      DispatchQueue.main.async {
        self.sendMessage(meetingID: meetingID, message: message, userID: userID, email: email) { result in

          switch result {
          case .success(let res):
            
            print("GÖNDERİLDİ")
          case .failure(let err):
            print(err)
          }
        }
      }
    }
  }
  func disconnect(){
    self.webSocketManager.disconnect()
  }
}
