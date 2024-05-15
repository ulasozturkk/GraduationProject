
import Foundation
import MapKit
import SwiftUI

class CreateMeetingViewModel: ObservableObject {
  @Published var Title: String = ""
  @Published var isOnline: Bool = false
  @Published var description: String = ""
  @Published var MeetingDate: Date = .now
  @Published var meetingLinkString: String = ""
  @Published var userlist: GetUserResponse = GetUserResponse(data: [], statusCode: 0, error: nil)
  @Published var invitedUserCheckList: [Bool] = []
  @Published var invitedUserList: [UserDTO] = []
  @Published var latitude: Double?
  @Published var longitude : Double?
  @Published var meetingLocation: Place?

  @Published var isMeetingCreated: Bool = false
  @Published var meetingCameraPosition = MapCameraPosition.automatic
  @Published var isLocationSettes : Bool = false
    
  func toggleAll() {
    if invitedUserCheckList.contains(true) {
      invitedUserCheckList = Array(repeating: false, count: userlist.data.count)
    } else {
      invitedUserCheckList = Array(repeating: true, count: userlist.data.count)
    }
  }
      
  func removeAllSelected() {
    invitedUserCheckList = Array(repeating: false, count: userlist.data.count)
  }
  
  func getAllUsers(){
    NetworkManager.shared.getAllUsers { result in
      switch result {
      case .success(let users):
        self.userlist = users
        for _ in users.data {
          self.invitedUserCheckList.append(false)
        }
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  func inviteUsers() {
    invitedUserList = []
    for (index, check) in invitedUserCheckList.enumerated() {
      if check == true {
        invitedUserList.append(userlist.data[index])
      }
    }
  }
  
 
  
  func validateTextFields() -> Bool {
  
      if Title != "" {
        if invitedUserList.count != 0 {
          return true
        } else {
          print("insanları davet etmesini iste")
        }
      } else {
        print("başlık girmesini iste")
        return false
      }
     
    return false
  }
  func setMeetingLocation(latitude:Double,longitude:Double,completion: @escaping (Bool)->()) {
    self.latitude = latitude
    self.latitude = longitude
    var meetingcameraposition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
    self.meetingCameraPosition = meetingcameraposition
    self.isLocationSettes = true
    completion(true)
  }
  
  func addFavPlace(completion: @escaping (Result<FavPlaceResponse,Error>)->Void){
    if let latitude = latitude, let longitude = longitude, let currentServiceUser = SessionManager.shared.currentServiceUser{
      let endpoint = Endpoint.addFavPlace(userID: currentServiceUser.userID, title: "Test", description: "test desc", latitude: latitude, longitude: longitude)
      NetworkManager.shared.createRequest(endpoint, completion: completion)
    }
    
  }
  
  private func getInvitedUserIDs() -> [String]{
    var useridlist : [String] = []
    for userid in invitedUserList {
      useridlist.append(userid.userID)
    }
    return useridlist
  }
  
  func createMeeting(completion: @escaping (Result<CreateMeetingResponse,Error>)->Void) {

    let endpoint = Endpoint.createMeeting(title: Title, description: description, time: MeetingDate.formatted(), isOnline: isOnline, meetingLink: meetingLinkString, latitude: latitude, longitude: longitude, ownerID: SessionManager.shared.currentServiceUser!.userID, invitedUsersIDList: getInvitedUserIDs())
    NetworkManager.shared.createRequest(endpoint, completion: completion)
  }
}
