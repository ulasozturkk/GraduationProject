

import Foundation

protocol EndPointProtocol {
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var header: [String: String]? { get }
  var parameters: [String: Any]? { get }

  var doubleParameters: Double? { get }
  func request() -> URLRequest
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

enum Endpoint {
  // MARK: - USER

  case createUser(email: String, password: String)
  case logInUser(email: String, password: String)
  case getAllUsers
  case getUsersByIDs(idList: [String])
  // MARK: - FAV PLACE

  case addFavPlace(userID: String, title: String, description: String, latitude: Double, longitude: Double)
  case getFavPlaceByID(favPlaceID: String)
  case getUsersFavPlaces
  case deleteFavPlace(favPlaceID: String)
  case updateFavPlace(favPlaceID: String, userID: String, title: String, description: String, latitude: Double, longitude: Double) // ???????

  // MARK: - FRIENDSHIP

  case sendFriendRequest(senderID: String, receiverID: String)
  case getUsersFriends
  case getUsersInvites
  case acceptInvite(friendID: String)
  case rejectInvite(friendID: String)

  // MARK: - MEETING

  case createMeeting(title: String, description: String, time: String, isOnline: Bool, meetingLink: String?,
                     latitude: Double?, longitude: Double?, ownerID: String, invitedUsersIDList: [String])
  case getUserMeetingInvitations
  case getUserMeetings
  case acceptMeeting(meetingID: String)
  case rejectMeeting(meetingID: String)
  case deleteMeeting(meetingID: String)
  case updateMeeting(meetingID: String, title: String, description: String, time: Date, isOnline: Bool, meetingLink: String?, latitude: Double?, longitude: Double?, ownerID: String, invitedUsersIDList: [String])
  case reviewMeeting(meetingID: String, reviewPoint: Double) // ???????

  // MARK: - MESSAGE

  case getMessages(meetingID: String)
  case addMessage(meetingID: String, message: String, userID: String) // ?????
}

extension Endpoint: EndPointProtocol {
  var baseURL: String {
    return "https://localhost:7130"
  }
    
  var path: String {
    switch self {
        // MARK: - USER
        
    case .createUser:
      return "/api/User/createUser"
    case .logInUser:
      return "/api/User/logInUser"
    case .getAllUsers:
      return "/api/User/getAllUsers"
    case .getUsersByIDs:
      return "/api/User/GetUsersByIDs"
        // MARK: - FAV PLACE
        
    case .addFavPlace:
      return "/api/FavPlace/addFavPlace"
    case .getFavPlaceByID:
      return "/api/FavPlace/getFavPlaceByID"
    case .getUsersFavPlaces:
      return "/api/FavPlace/getUsersFavPlaces"
    case .deleteFavPlace:
      return "/api/FavPlace/deleteFavPlace"
    case .updateFavPlace:
      return "/api/FavPlace/updateFavPlace"
        
        // MARK: - FRIENDSHIP
        
    case .sendFriendRequest:
      return "/api/Friendship/sendFriendRequest"
    case .getUsersFriends:
      return "/api/Friendship/getUsersFriends"
    case .getUsersInvites:
      return "/api/Friendship/getUsersInvites"
    case .acceptInvite:
      return "/api/Friendship/acceptInvite"
    case .rejectInvite:
      return "/api/Friendship/rejectInvite"
        
        // MARK: - MEETING
        
    case .createMeeting:
      return "/api/Meeting"
    case .getUserMeetingInvitations:
      return "/api/Meeting/getUserMeetingInvitations"
    case .getUserMeetings:
      return "/api/Meeting/getUserMeetings"
    case .acceptMeeting:
      return "/api/Meeting/acceptMeeting"
    case .rejectMeeting:
      return "/api/Meeting/rejectMeeting"
    case .deleteMeeting:
      return "/api/Meeting/deleteMeeting"
    case .updateMeeting:
      return "/api/Meeting/updateMeeting"
    case .reviewMeeting:
      return "/api/Meeting/reviewMeeting"
        
        // MARK: - MESSAGE
        
    case .getMessages:
      return "/api/Message/getMessages"
    case .addMessage:
      return "/api/Message/addMessage"
    }
  }
  
  var parameters: [String: Any]? {
    if case .addFavPlace(let userID, let title, let description, let latitude, let longitude) = self {
      return ["userID": userID, "title": title, "description": description, "latitude": latitude, "longitude": longitude]
    } else if case .updateFavPlace(let favPlaceID, let userID, let title, let description, let latitude, let longitude) = self {
      return ["userID": userID, "title": title, "description": description, "latitude": latitude, "longitude": longitude]
    } else if case .sendFriendRequest(let senderID, let receiverID) = self {
      return ["senderID": senderID, "receiverID": receiverID]
    } else if case .createMeeting(let title, let description, let time, let isOnline, let meetingLink, let latitude, let longitude, let ownerID, let invitedUsersIDList) = self {
      return ["title": title,
              "description": description,
              "time": time,
              "isOnline": isOnline,
              "meetingLink": meetingLink,
              "latitude": latitude,
              "longitude": longitude,
              "ownerID": ownerID,
              "invitedUsersIDList": invitedUsersIDList]
    }
    else if case .getUsersByIDs(let idList) = self {
      return ["userIDList": idList]
    }
    else if case .updateMeeting(let meetingID, let title, let description, let time, let isOnline, let meetingLink, let latitude, let longitude, let ownerID, let invitedUsersIDList) = self {
      return [
        "meetingID": meetingID,
        "title": title,
        "description": description,
        "time": time,
        "isOnline": isOnline,
        "meetingLink": meetingLink,
        "latitude": latitude,
        "longitude": longitude,
        "ownerID": ownerID,
        "invitedUsersIDList": invitedUsersIDList,
      ]
    } else if case .addMessage(let meetingID, let message, let userID) = self {
      return ["message": message, "userID": userID]
    } else if case .createUser(let email, let password) = self {
      return ["email": email, "password": password]
    } else if case .logInUser(let email, let password) = self {
      return ["email": email, "password": password]
    } else if case .acceptMeeting(let meetingID) = self {
      return ["meetingID": meetingID]
    } else if case .rejectMeeting(let meetingID) = self {
      return ["meetingID": meetingID]
    } else if case .deleteMeeting(let meetingID) = self {
      return ["meetingID": meetingID]
    }
    
    else { return nil }
  }
  

  var doubleParameters: Double? {
    switch self {
    case .reviewMeeting(_, let reviewPoint):
      return reviewPoint
    default:
      return nil
    }
  }
    
  var method: HTTPMethod {
    switch self {
    case .createUser, .logInUser, .addFavPlace, .sendFriendRequest, .createMeeting,.acceptMeeting, .addMessage,.getUsersByIDs, .getAllUsers:
      return .post
    case .getFavPlaceByID, .getUsersFavPlaces, .getUsersFriends, .getUsersInvites, .getUserMeetingInvitations, .getUserMeetings, .getMessages:
      return .get
    case .deleteFavPlace, .updateFavPlace, .acceptInvite, .rejectInvite,  .rejectMeeting, .deleteMeeting, .updateMeeting, .reviewMeeting:
      return .put
    }
  }
    
  var header: [String: String]? { // TODO: burası keychaine set edilecek
    if let token = SessionManager.shared.currentServiceUser?.accessToken {
      return ["Authorization": "Bearer \(token)"]
    } else {
     let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjgyNzQ3NmQzLTM2M2QtNDM4Yi1hNWZhLTg3OThjMTU1YWM5NSIsImVtYWlsIjoic3dpZnR0ZXN0MUB0ZXN0LmNvbSIsImp0aSI6ImRjNDE3ZGRhLTQ5YzAtNDhlMy05ODlmLTcwNmQwOGI0NjlkNSIsImF1ZCI6Ind3dy51bGFzb3p0dXJrLmRldiIsIm5iZiI6MTcxNTcxMDk0NSwiZXhwIjoxNzE1NzI4OTQ1LCJpc3MiOiJ3d3cudWxhc296dHVyay5kZXYifQ.RcyjfEBVLQIIhiYNZRVPO-O3Tw0gf9rjehDSu8P_mT8"

      return ["Authorization": "Bearer \(token)"]
    }
  }
    
  func request() -> URLRequest {
    guard var components = URLComponents(string: baseURL) else {
      fatalError("URL ERROR")
    }
    components.path = path
      
    switch self {
    case .getFavPlaceByID(let favPlaceID), .deleteFavPlace(let favPlaceID), .updateFavPlace(let favPlaceID, _, _, _, _, _):
      components.queryItems = [URLQueryItem(name: "favPlaceID", value: favPlaceID)]
    case .acceptInvite(let friendID), .rejectInvite(let friendID):
      components.queryItems = [URLQueryItem(name: "friendID", value: friendID)]
    case .getMessages(let meetingID), .reviewMeeting(let meetingID, _), .addMessage(let meetingID, _, _):
      components.queryItems = [URLQueryItem(name: "meetingID", value: meetingID)]
    default:
      break
    }
    var request = URLRequest(url: components.url!)
    request.httpMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let parameters = parameters {
      do {
        // Önce parameters içindeki tarih ve saat nesnelerini uygun biçime dönüştürün
        var modifiedParameters = parameters
        if let time = parameters["time"] as? Date {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
          let formattedTime = dateFormatter.string(from: time)
          modifiedParameters["time"] = time
        }

        
        let jsonData = try? JSONSerialization.data(withJSONObject: modifiedParameters, options: [])
        print(jsonData)
        request.httpBody = jsonData!

      }
    }
      
    if let doubleParameters = doubleParameters {
      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: doubleParameters)
      } catch {
        print(error.localizedDescription)
      }
    }
    if let header = header {
      for (key, value) in header {
        request.setValue(value, forHTTPHeaderField: key)
      }
    }
    return request
  }
}
