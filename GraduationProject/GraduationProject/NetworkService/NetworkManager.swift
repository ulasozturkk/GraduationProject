
import Foundation

class NetworkManager{
  static let shared = NetworkManager()
  private init(){}
  
  func createRequest<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) {
    let session = URLSession(configuration: .default, delegate: Delegate(), delegateQueue: nil)
    let task = session.dataTask(with: endpoint.request()) { data, response, error in
      if let error = error {
        completion(.failure(error))
      }
      if let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 399 {
        print(response.statusCode)
      }
      guard let data = data else {
        print("data gelmedi")
        return
      }
      
      do {
        print(String(data: data, encoding: .utf8))
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        completion(.success(decodedData))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
  func createUser(email:String,password:String,completion: @escaping (Result<AuthResponse,Error>)-> Void) {
    let endpoint = Endpoint.createUser(email: email, password: password)
    createRequest(endpoint, completion: completion)
  }
  
  func signInUser(email:String,password:String,completion: @escaping (Result<AuthResponse,Error>)->Void){
    let endpoint = Endpoint.logInUser(email: email, password: password)
    createRequest(endpoint, completion: completion)
  }
  
  func getUserMeetings(completion: @escaping (Result<UserMeetingResponse,Error>)-> Void){
    let endpoint = Endpoint.getUserMeetings
    createRequest(endpoint, completion: completion)
    
  }
  func getAllUsers(completion: @escaping (Result<GetUserResponse,Error>)->Void) {
    let endpoint = Endpoint.getAllUsers
    createRequest(endpoint, completion: completion)
  }

  
  class Delegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
      if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
        if let serverTrust = challenge.protectionSpace.serverTrust {
          let credential = URLCredential(trust: serverTrust)
          completionHandler(.useCredential, credential)
          return
        }
      }
      completionHandler(.performDefaultHandling, nil)
    }
  }
}
