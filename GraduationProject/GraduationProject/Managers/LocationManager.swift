import CoreLocation
import SwiftUI
import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  @Published var userLocation: CLLocationCoordinate2D?
  @Published var region = MKCoordinateRegion()
  @Published var cameraPosition : MapCameraPosition = .automatic
  var locationManager = CLLocationManager()

  var binding: Binding<MKCoordinateRegion> {
    Binding {
      self.region
    } set: { newregion in
      self.region = newregion
    }
  }

  override init() {
    super.init()
    locationManager.delegate = self
  }

  func requestLocation() {
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
      cameraPosition = .region(region)
      userLocation = location.coordinate
    }
  }
}
