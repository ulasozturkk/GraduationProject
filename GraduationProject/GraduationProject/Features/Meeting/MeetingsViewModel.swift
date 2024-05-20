import Foundation

class MeetingsViewModel: ObservableObject {
  @Published var meetingResponse: UserMeetingResponse = .init(data: [], statusCode: 0, error: nil)
  @Published var currentMeetings: UserMeetingResponse = .init(data: [], statusCode: 0, error: nil)
  @Published var pastMeetings: UserMeetingResponse = .init(data: [], statusCode: 0, error: nil)
  @Published var userInvitationsResponse: UserMeetingResponse = .init(data: [], statusCode: 0, error: nil)
  @Published var friendRequsestResponse: UsersFriendsResponse = .init(data: [], statusCode: 0, error: nil)
  @Published var isLoading: Bool = false

  
  func stringToDate(_ dateString: String) -> Date? {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm"
      dateFormatter.locale = Locale(identifier: "en_US_POSIX") // İngilizce yerel ayarını kullanıyoruz

      // Formatlanamayan dizeye karşı hatayı ele al
      guard let date = dateFormatter.date(from: dateString) else {
          print("Hata: Geçersiz tarih formatı - \(dateString)")
          return nil
      }

      return date
  }
  
  
  func fetchMeetings() {
    let currentDate = Date()
    self.isLoading = true
    if (SessionManager.shared.currentServiceUser?.userID) != nil {
      DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        DispatchQueue.main.async {
          NetworkManager.shared.getUserMeetings { result in
            switch result {
            case .success(let res):
              for meeting in res.data {
                if let meetingDate = self.stringToDate(meeting.time){
                  if currentDate <= meetingDate {
                    if !self.meetingResponse.data.contains(meeting){
                      self.meetingResponse.data.append(meeting)
                    }
                  }
                }
              }
              self.isLoading = false
            case .failure(let err):
              print(err.localizedDescription)
              self.isLoading = false
            }
          }
        }
      }
    }
  }

  private func getUserMeetingInvitations(completion: @escaping (Result<UserMeetingResponse, Error>)-> Void) {
    if SessionManager.shared.currentServiceUser?.userID != nil {
      let endpoint = Endpoint.getUserMeetingInvitations
      NetworkManager.shared.createRequest(endpoint, completion: completion)
    }
  }

  func fetchInvitations() {
    self.isLoading = true
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
      DispatchQueue.main.async {
        self.getUserMeetingInvitations { result in
          switch result {
          case .success(let response):
            self.userInvitationsResponse = response
            self.isLoading = false
          case .failure(let err):
            print(err)
            self.isLoading = false
          }
        }
      }
    }
  }

  private func acceptMeeting(meetingID: String, completion: @escaping (Result<NoDataResponse, Error>)->Void) {
    let endpoint = Endpoint.acceptMeeting(meetingID: meetingID)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }

  func accept(meetingID: String) {
    var meetingIndex = 0
    self.acceptMeeting(meetingID: meetingID) { result in
      switch result {
      case .success(let res):
        for (index, meeting) in self.userInvitationsResponse.data.enumerated() {
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

  private func rejectMeeting(meetingID: String, completion: @escaping (Result<NoDataResponse, Error>)->Void) {
    let endpoint = Endpoint.rejectMeeting(meetingID: meetingID)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }

  func reject(meetingID: String) {
    var meetingIndex = 0
    self.rejectMeeting(meetingID: meetingID) { result in
      switch result {
      case .success(let res):
        for (index, meeting) in self.userInvitationsResponse.data.enumerated() {
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

  private func fetchFriendInvites(completion: @escaping (Result<UsersFriendsResponse, Error>)->Void) {
    let endpoint = Endpoint.getUsersInvites
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }

  func getUsersInvites() {
    self.isLoading = true
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      DispatchQueue.main.async {
        self.fetchFriendInvites { result in
          switch result {
          case .success(let res):
            self.friendRequsestResponse = res
            self.isLoading = false
          case .failure(let err):
            print(err)
            self.isLoading = false
          }
        }
      }
    }
  }

  private func acceptInvite(friendID: String, completion: @escaping (Result<NoDataResponse, Error>)->Void) {
    let endpoint = Endpoint.acceptInvite(friendID: friendID)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }

  private func rejectInvite(friendID: String, completion: @escaping (Result<NoDataResponse, Error>)->Void) {
    let endpoint = Endpoint.rejectInvite(friendID: friendID)
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }

  func acceptFriend(friendID: String) {
    self.isLoading = true
    var friendshipIndex = 0
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
      DispatchQueue.main.async {
        self.acceptInvite(friendID: friendID) { result in
          switch result {
          case .success(let res):
            for (index, invite) in self.friendRequsestResponse.data.enumerated() {
              if invite.userID == friendID {
                friendshipIndex = index
              }
            }
            self.friendRequsestResponse.data.remove(at: friendshipIndex)
          case .failure(let err):
            print(err)
          }
        }
      }
    }
  }

  func rejectFriend(friendID: String) {
    self.isLoading = true
    var friendshipIndex = 0
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
      DispatchQueue.main.async {
        self.rejectInvite(friendID: friendID) { result in
          switch result {
          case .success(let res):
            for (index, invite) in self.friendRequsestResponse.data.enumerated() {
              if invite.userID == friendID {
                friendshipIndex = index
              }
            }
            self.friendRequsestResponse.data.remove(at: friendshipIndex)
          case .failure(let err):
            print(err)
          }
        }
      }
    }
  }
}
