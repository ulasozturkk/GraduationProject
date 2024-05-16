import Foundation

class MeetingsViewModel: ObservableObject {
  @Published var meetingResponse: UserMeetingResponse = UserMeetingResponse(data: [], statusCode: 0, error: nil)
  @Published var userInvitationsResponse : UserMeetingResponse = UserMeetingResponse(data: [], statusCode: 0, error: nil)
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
  private func getUserMeetingInvitations(completion: @escaping (Result<UserMeetingResponse,Error>)-> Void){
    if SessionManager.shared.currentServiceUser?.userID != nil {
      var endpoint = Endpoint.getUserMeetingInvitations
      NetworkManager.shared.createRequest(endpoint, completion: completion)
    }
  }
  
  func fetchInvitations(){
    getUserMeetingInvitations { result in
      switch result {
      case .success(let response):
        self.userInvitationsResponse = response
      case .failure(let err):
        print(err)
      }
    }
  }
  
  private func acceptMeeting(meetingID: String,completion: @escaping (Result<NoDataResponse,Error>)->Void){
    let endpoint = Endpoint.acceptMeeting(meetingID: meetingID)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }
  func accept(meetingID: String){
    var meetingIndex = 0
    acceptMeeting(meetingID: meetingID) { result in
      switch result {
      case .success(let res):
        for (index,meeting )in self.userInvitationsResponse.data.enumerated() {
          if meeting.meetingID == meetingID {
            meetingIndex = index
          }
        }
        self.userInvitationsResponse.data.remove(at: meetingIndex)
      case .failure(let err):
        print(err)
      }
    }
  }
  private func rejectMeeting(meetingID:String,completion: @escaping (Result<NoDataResponse,Error>)->Void){
    let endpoint = Endpoint.rejectMeeting(meetingID: meetingID)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }
  func reject(meetingID:String) {
    var meetingIndex = 0
    rejectMeeting(meetingID: meetingID) { result in
      switch result {
      case .success(let res):
        for (index,meeting) in self.userInvitationsResponse.data.enumerated() {
          if meeting.meetingID == meetingID {
            meetingIndex = index
          }
          
        }
        self.userInvitationsResponse.data.remove(at: meetingIndex)
      case .failure(let err):
        print(err)
      }
    }
  }
}
