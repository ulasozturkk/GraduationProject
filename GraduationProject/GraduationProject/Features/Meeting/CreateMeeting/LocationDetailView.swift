
import MapKit
import SwiftUI

struct LocationDetailView: View {
  @Environment(\.dismiss) var dismiss
  @State var selectedLocation : SelectedPlace = SelectedPlace(title: "", latitude: 0, longitude: 0)
  @State var isLocarionFav = false
  @StateObject var VM: CreateMeetingViewModel
  var manager = CLLocationManager()
  @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
  var body: some View {
    NavigationStack {
      VStack {
        HStack {
          VStack(alignment: .leading) {
            Text("Selected Location")
              .modifier(Title())
          }
          
          Spacer()
          Button("Save") {
            VM.latitude = selectedLocation.latitude
            VM.longitude = selectedLocation.longitude
            dismiss()
          }
        }
        MapReader { proxy in
          Map(position: $position) {
            UserAnnotation()
            if selectedLocation.title != "" {
              Annotation(selectedLocation.title, coordinate: CLLocationCoordinate2D(
                latitude: selectedLocation.latitude, longitude: selectedLocation.longitude)) {
                  Image(systemName: "star.circle")
                    .resizable()
                    .foregroundStyle(.red)
                    .frame(width: 44, height: 44)
                    .background(.white)
                    .clipShape(.circle)
                }
            }
          }.onTapGesture { position in
            if let coordinate = proxy.convert(position, from: .local) {
              var selectedLocation = SelectedPlace(title: "Selected Place", latitude: coordinate.latitude, longitude: coordinate.longitude)
              self.selectedLocation = selectedLocation
              VM.setMeetingLocation(latitude: coordinate.latitude, longitude: coordinate.longitude) { _ in}
            }
          }
        }
        .onAppear {
          manager.requestWhenInUseAuthorization()
        }
      }
    }
      
    .padding()
    Spacer()
    VStack {
      if isLocarionFav == false {
        CustomButton(buttonText: "Add Favorites") {
          VM.latitude = selectedLocation.latitude
          VM.longitude = selectedLocation.longitude
          VM.addFavPlace { result in
            switch result {
            case .success(let res):
              isLocarionFav = true
            case .failure(let err):
              print(err.localizedDescription)
            }
          }
        }
      }else {
        Text("This location already added to favorites").modifier(SubTitle())
      }
      CustomButton(buttonText: "Open In Maps") {
        let url = URL(string: "maps://?saddr=&daddr=\(selectedLocation.latitude),\(selectedLocation.longitude)")
        if UIApplication.shared.canOpenURL(url!) {
          UIApplication.shared.open(url!, options: [:])
        }
      }
    }
    Spacer()
  }
}

struct SelectedPlace {
  var title: String
  var latitude: Double
  var longitude: Double
}
