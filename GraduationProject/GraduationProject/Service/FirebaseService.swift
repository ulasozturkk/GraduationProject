import FirebaseAuth
import FirebaseFirestore
import Foundation

class FirebaseService {
  static let shared = FirebaseService()
  private init() {}
  
  func AddUser(username: String, password: String, email: String) {
    let firestore = Firestore.firestore()
    let userCollectionRef = firestore.collection("users")
    
    let userid = Auth.auth().currentUser?.uid
    let userRef = userCollectionRef.document(userid!)
    
    let mydata: [String: Any] = [
      "email": email,
      "username": username,
      "password": password,
    ]
    
    userRef.setData(mydata) { error in
      if let error = error {
        print("Kullanıcı belgesi eklenirken hata oluştu: \(error)")
        return
      }
      print("Kullanıcı belgesi başarıyla eklendi.")
    }
    var user = User(id: userid!, username: username, email: (Auth.auth().currentUser?.email)!, password: password)
    SessionManager.shared.setUser(user: user)
  }
  
  func CreateMeeting(meeting: Meeting) {
    let firestore = Firestore.firestore()
    let userCollectionRef = firestore.collection("users")
    
    let userid = Auth.auth().currentUser?.uid
    let userRef = userCollectionRef.document(userid!)
    
    let meetingCollectionRef = userRef.collection("meetings")
    
    let meetingData: [String: Any] = [
      "id": generateRandomString(length: 10),
      "isOnline": meeting.isOnline,
      "location": meeting.locaiton,
      "time": meeting.time,
      "title": meeting.title,
      "quests": meeting.quests,
      "price": meeting.price,
      "meetingLink": meeting.meetingLink,
    ]
    
    meetingCollectionRef.addDocument(data: meetingData) { error in
      if let error = error {}
    }
    InviteMeeting(quests: ["GfFGnSZOzKgePsaIWAheG28NqY13", "xqcH7ZWeNUPoO4sKEyJIYN6O8nf1"], meetingData: meetingData)
  }
  
  func InviteMeeting(quests: [String], meetingData: [String: Any]) {
    let firestore = Firestore.firestore()
    let userCollectionRef = firestore.collection("users")
    
    let userIdList = userCollectionRef.getDocuments { snapshot, error in
      if let error = error {
        print("Kullanıcı belgeleri alınırken hata oluştu: \(error)")
        return
      }
      
      guard let snapshot = snapshot else { return }
      
      for document in snapshot.documents {
        for userId in quests {
          if document.documentID == userId {
            let userRef = userCollectionRef.document(userId)
            let meetingInvitesRef = userRef.collection("meetingInvites")
           
            meetingInvitesRef.addDocument(data: meetingData) { error in
              if let error = error {
                print("Toplantı daveti eklenirken hata oluştu: \(error)")
              }
            }
          }
        }
      }
    }
  }
  
  func AcceptMeeting(meetingData: [String: Any]) {
    // currentuser ın invite ına ulaş
    let firestore = Firestore.firestore()
    let userCollectionRef = firestore.collection("users")
    // mevcut dokumanı al
    let userid = Auth.auth().currentUser?.uid
    let userRef = userCollectionRef.document(userid!)
    // meetings collectionu oluştur içine ekle
    let meetingCollectionRef = userRef.collection("meetings")
    
    meetingCollectionRef.addDocument(data: meetingData) { error in
      if let error = error {}
    }
  }
  
  func RejectMeeting(meetingid: String) {
    let firestore = Firestore.firestore()
    let userCollectionRef = firestore.collection("users")
    let userid = Auth.auth().currentUser?.uid
    let userRef = userCollectionRef.document(userid!)
    let meetingInvitesRef = userRef.collection("meetingInvites")
    
    meetingInvitesRef.getDocuments { snapshot, error in
      guard error == nil else { return }
      guard let snapshot = snapshot else { return }
      
      for document in snapshot.documents {
        let dict = document.data()
        let id = dict["id"] as? String
        if id == meetingid {
          let documentID = document.documentID
          meetingInvitesRef.document(documentID).delete { error in
            if let error = error {
              print("Error deleting document: \(error)")
            } else {
              print("Document successfully deleted")
            }
          }
        }
      }
    }
  }
}
