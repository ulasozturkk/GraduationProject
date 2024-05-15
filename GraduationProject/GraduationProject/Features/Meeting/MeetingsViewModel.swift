import Foundation

class MeetingsViewModel: ObservableObject {
  @Published var meetingResponse: UserMeetingResponse = UserMeetingResponse(data: [], statusCode: 0, error: nil)

  func fetchMeetings() {
    if (SessionManager.shared.currentServiceUser?.userID) != nil {
      NetworkManager.shared.getUserMeetings { result in
        switch result {
        case .success(let res):
          self.meetingResponse = res
        case .failure(let err):
          print(err.localizedDescription)
        }
      }
    }
  }
}
