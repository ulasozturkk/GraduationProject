import SwiftUI

struct CustomIconButton: View {
  let action: () -> Void
  let sh = UIScreen.main.bounds.height
  let sw = UIScreen.main.bounds.width
  let buttonImage: ImageResource
  let isNotificationButton: Bool?
  let notCount: Int?

  init(action: @escaping () -> Void, buttonImage: ImageResource, isNotificationButton: Bool?, notCount: Int?) {
    self.action = action
    self.buttonImage = buttonImage
    self.isNotificationButton = isNotificationButton
    self.notCount = notCount
  }

  init(action: @escaping () -> Void,buttonImage: ImageResource){
    self.action = action
    self.buttonImage = buttonImage
    self.isNotificationButton = nil
    self.notCount = nil
  }

  var body: some View {
    if isNotificationButton == true {
      ZStack(alignment: .topTrailing) {
        Button(action: action) {
          Image(buttonImage)
            .resizable()
            .frame(width: sw * 0.15, height: sw * 0.15)
        }
        ZStack {
          Circle()
            .frame(width: sw * 0.05, height: sw * 0.05)
            .foregroundStyle(Color(Colors.green.rawValue))
          Text(String(notCount!))
            .modifier(Description())
            .foregroundStyle(.white)
        }
      }
    } else {
      Button(action: action) {
        Image(buttonImage)
          .resizable()
          .frame(width: sw * 0.15, height: sw * 0.15)
      }
    }
  }
}
