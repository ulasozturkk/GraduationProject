import Foundation

class PastMeetingsViewModel : ObservableObject {
  @Published var meetingResponse: UserMeetingResponse = .init(data: [], statusCode: 0, error: nil)
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
                  if currentDate >= meetingDate {
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
}
