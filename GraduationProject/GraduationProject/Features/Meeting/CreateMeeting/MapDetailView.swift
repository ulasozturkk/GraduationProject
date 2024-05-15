import SwiftUI
import MapKit

struct IdentifiableMKPointAnnotation: Identifiable {
    var id = UUID()
    var annotation: MKPointAnnotation
}

struct MapView: View {
    @StateObject var locationManager = LocationManager()
    @State private var selectedLocation: IdentifiableMKPointAnnotation?
    
    var body: some View {
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: [selectedLocation].compactMap { $0 }) { location in
          MapPin(coordinate: location.annotation.coordinate)
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .onTapGesture {
            // Assume user taps on the map to select a location
            let location = locationManager.userLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
            let newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = location
            selectedLocation = IdentifiableMKPointAnnotation(annotation: newAnnotation)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
