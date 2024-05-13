import SwiftUI

struct CustomImage: View {
  let imagename: ImageResource
  let sw = UIScreen.main.bounds.width
  var body: some View {
    Image(imagename)
      .resizable()
      .frame(width: sw * 0.1, height: sw * 0.1)
  }
}
