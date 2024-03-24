

import SwiftUI

struct CustomButton: View {
  let buttonText: String
  let sh = UIScreen.main.bounds.height
  let sw = UIScreen.main.bounds.width
  let action : ()->()
  let isItTextButton: Bool?
  init(buttonText: String, action: @escaping () -> Void, isItTextButton: Bool? = nil) {
    self.buttonText = buttonText
    self.action = action
    self.isItTextButton = isItTextButton
  }
    var body: some View {
      Button(action: action, label: {
        
        if isItTextButton != nil && isItTextButton == true {
          Text(buttonText)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundStyle(Color(Colors.green.rawValue))
        } else {
          ZStack{
            RoundedRectangle(cornerRadius: sw / 2)
              .foregroundStyle(Color(Colors.green.rawValue))
              .frame(width: sw * 0.9 , height: sh * 0.07)
            Text(buttonText)
              .font(.subheadline)
              .fontWeight(.bold)
              .foregroundStyle(Color.white)

          }
        }
        
      })
    }
}

