import Foundation

class PastMeetingsViewModel: ObservableObject {
    @Published var meetingResponse: UserMeetingResponse = .init(data: [], statusCode: 0, error: nil)
    @Published var isLoading: Bool = false
    @Published var reviewPoint: Double = 0

    func stringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Use English locale
        
        // Handle unparseable string
        guard let date = dateFormatter.date(from: dateString) else {
            print("Error: Invalid date format - \(dateString)")
            return nil
        }
        
        return date
    }
    
    func fetchMeetings() {
        let currentDate = Date()
        self.isLoading = true
        if let userID = SessionManager.shared.currentServiceUser?.userID {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                DispatchQueue.main.async {
                    NetworkManager.shared.getUserMeetings { result in
                        switch result {
                        case .success(let res):
                            for meeting in res.data {
                                if let meetingDate = self.stringToDate(meeting.time) {
                                    if currentDate >= meetingDate {
                                        if !self.meetingResponse.data.contains(meeting) {
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
    
    private func giveReview(meetingID: String, completion: @escaping (Result<NoDataResponse, Error>) -> Void) {
        let endpoint = Endpoint.reviewMeeting(meetingID: meetingID, reviewPoint: self.reviewPoint)
        NetworkManager.shared.createRequest(endpoint, completion: completion)
    }
    
    func reviewMeeting(meetingID: String) {
        self.isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                self.giveReview(meetingID: meetingID) { (result: Result<NoDataResponse, Error>) in
                    self.isLoading = false
                    switch result {
                    case .success:
                        print("success")
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            }
        }
    }
}
