
import SwiftUI

struct CustomToggle: View {
  @Binding var isOn : Bool
  let ToggleText: String
    var body: some View {
      Toggle(isOn: $isOn, label: {
        Text(ToggleText)
          .modifier(Description())
          
      })
    }
}


