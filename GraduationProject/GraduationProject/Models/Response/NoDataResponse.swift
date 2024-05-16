
import Foundation

struct NoDataResponse : Codable {
  var data: [String]?
  let statusCode: Int
  let error: String?
  enum CodingKeys: String, CodingKey {
          case data
          case statusCode
          case error
      }
}
