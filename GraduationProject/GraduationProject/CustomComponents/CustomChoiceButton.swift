
import SwiftUI

struct CustomChoiceButton: View {
  let sh = UIScreen.main.bounds.height
  let sw = UIScreen.main.bounds.width
  let action : ()->()
  let isAccept : Bool?
    var body: some View {
      ZStack{
        if(isAccept! == true){
          Button(action: action, label: {
            RoundedRectangle(cornerRadius: 15)
              .foregroundStyle(.green)
              .frame(width: sw * 0.1, height: sw * 0.1)
            Image(systemName: "checkmark")
              .font(.title)
              .foregroundStyle(.white)
          })
        }else {
          Button(action: action, label: {
            RoundedRectangle(cornerRadius: 15)
              .foregroundStyle(.red)
              .frame(width: sw * 0.1, height: sw * 0.1)
            Image(systemName: "nosign")
              .font(.title)
              .foregroundStyle(.white)
          })
        }
        }
        
    }
}


