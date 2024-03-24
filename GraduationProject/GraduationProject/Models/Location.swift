import Foundation
import MapKit

struct Place {
  var title: String
  
  var latitude : CLLocationDegrees
  var longitude: CLLocationDegrees
  
  var location : CLLocationCoordinate2D {
   return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
  
}
