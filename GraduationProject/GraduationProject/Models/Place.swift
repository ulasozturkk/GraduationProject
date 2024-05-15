import Foundation

struct Place: Identifiable {
    let id: String
    let title: String
    let description: String
    let latitude: Double
    let longitude: Double
    let isRemoved: Bool?
    let userID: String
   
}
