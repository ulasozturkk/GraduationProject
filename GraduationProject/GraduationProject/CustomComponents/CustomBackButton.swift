

import SwiftUI

struct CustomBackButton: View {
  let action : () -> ()
    var body: some View {
      Button(action: action) {
        Image(systemName: "chevron.backward")
          .resizable()
          .foregroundColor(Color(Colors.green.rawValue))
          .frame(width: 20, height: 20)
      }
    }
}

