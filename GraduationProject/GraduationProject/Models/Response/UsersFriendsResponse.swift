
struct UsersFriendsResponse: Codable {
    var data: [Datum]
    let statusCode: Int
    let error: JSONNull?
}

// MARK: - Datum
struct Datum: Codable {
  let id: String
  let userID, email: String
}
