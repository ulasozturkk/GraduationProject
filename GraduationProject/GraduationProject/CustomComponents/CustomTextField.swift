

import SwiftUI

struct CustomTextField: View {
  @Binding var text: String
  let placeHolderText: String
  let systemImage: String
  let isSecured: Bool
  
  var body: some View {
    HStack {
      Image(systemName: systemImage)
        .padding(.leading, 10)
        .foregroundColor(.black)
        .frame(width: 30, height: 30)
      
      if isSecured {
        SecureField(placeHolderText, text: $text)
          .padding(.vertical, 10)
          .disableAutocorrection(true)
          .textInputAutocapitalization(.never)
          .textContentType(.none)
          
      } else {
        TextField(placeHolderText, text: $text)
          .padding(.vertical, 10)
          .textInputAutocapitalization(.never)
          .textContentType(.none)
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 12)
        .stroke(Color(Colors.green.rawValue), lineWidth: 1)
    )
    .foregroundColor(Color(Colors.black.rawValue))
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color(Colors.textfield.rawValue))
    )
  }
}
