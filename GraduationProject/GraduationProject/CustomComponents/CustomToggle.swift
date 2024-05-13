
import SwiftUI


struct CustomToggle: View {
  @Binding var isOn : Bool
  let textColor: String
  let ToggleText: String
    var body: some View {
      Toggle(isOn: $isOn, label: {
        Text(ToggleText)
          .modifier(Description(color: textColor))

      })
    }
}
