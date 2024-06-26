
import Foundation
import SwiftUI

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title)
      .fontWeight(.bold)
  }
}
struct SubTitle: ViewModifier{
  func body(content: Content) -> some View {
    content
      .font(.body)
      .fontWeight(.regular)
  }
}
struct Description : ViewModifier {
  let color : String
  func body(content: Content) -> some View {
    content
      .font(.caption)
      .fontWeight(.light)
      .foregroundStyle(Color(color))
  }
}
