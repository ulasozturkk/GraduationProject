
import SwiftUI

struct MeetingChatView: View {
  let sh = UIScreen.main.bounds.height
  var meeting: Meeting
  @Environment(\.dismiss) var dismiss
  @State var msg: String = ""
  var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          VStack {
            Text("meeting title").modifier(Title())
            Text("meeting ID").modifier(SubTitle())
            
            ChatMessageCell(isFromCurrentUser: false)
            ChatMessageCell(isFromCurrentUser: false)
            ChatMessageCell(isFromCurrentUser: true)
            ChatMessageCell(isFromCurrentUser: false)
            ChatMessageCell(isFromCurrentUser: true)
          }
        }
        Spacer()
        
        ZStack(alignment: .trailing) {
          CustomTextField(text: $msg, placeHolderText: "your message", systemImage: "message", isSecured: false)
          CustomIconButton(action: {}, buttonImage: .plusbutton, customSize: sh * 0.03).padding(.horizontal)
        }
      }
    }.toolbar {
      ToolbarItem(placement: .topBarLeading) {
        CustomBackButton {
          dismiss()
        }
      }
    }
  }
}

struct ChatMessageCell: View {
  let isFromCurrentUser: Bool
  let sh = UIScreen.main.bounds.height
  var body: some View {
    if isFromCurrentUser {
      HStack {
        Spacer()
        ZStack {
          RoundedRectangle(cornerRadius: 12).foregroundStyle(.green)
          Text("some message text but it has multilme strimgdjfslgmsdfgdmfgdsfgd")
            .modifier(SubTitle())
            .foregroundStyle(.white)
            .padding()
        }
        .frame(width: sh * 0.3, height: sh * 0.1)
        .padding()
      }
    } else {
      HStack {
        VStack(alignment: .leading) {
          HStack {
            CustomImage(imagename: .profileIcon)
            Text("email").modifier(SubTitle())
          }
          ZStack {
            RoundedRectangle(cornerRadius: 12).foregroundStyle(.gray)
            Text("some message text but it has multilme strimgdjfslgmsdfgdmfgdsfgd")
              .modifier(SubTitle())
              .foregroundStyle(.white)
              .padding()
          }.frame(width: sh * 0.3)
        }
        Spacer()
      }.padding()
    }
  }
}

