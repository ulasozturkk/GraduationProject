
struct FavPlaceResponse: Codable {
    let data: DataClass
    let statusCode: Int
    let error: JSONNull?
  
  struct DataClass: Codable {
      let userID, title, description: String
      let latitude, longitude: Double
  }

}

// MARK: - DataClass
