
import SwiftUI

struct MeetingChatView: View {
  let sh = UIScreen.main.bounds.height
  var meeting: Meeting
  @Environment(\.dismiss) var dismiss
  @State var msg: String = ""
  @StateObject var VM = MeetingChatViewModel()
  var userID = SessionManager.shared.currentServiceUser?.userID


  var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          VStack {
            Text(meeting.title).modifier(Title())
            Text(meeting.time).modifier(SubTitle())

            if VM.isLoading {
              ProgressView()
            } else {
              ForEach(VM.messages.data, id: \.messageID) { message in
                ChatMessageCell(isFromCurrentUser: message.userID == self.userID, message: message)
              }
            }
          }
        }
        Spacer()

        ZStack(alignment: .trailing) {
          CustomTextField(text: $msg, placeHolderText: "your message", systemImage: "message", isSecured: false)
          CustomIconButton(action: {
            VM.sendMessage(meetingID: meeting.meetingID, message: msg, userID: SessionManager.shared.currentServiceUser!.userID, email: SessionManager.shared.currentServiceUser!.email)

          }, buttonImage: .plusbutton, customSize: sh * 0.03).padding(.horizontal)
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        CustomBackButton {
          VM.disconnect()
          dismiss()
        }
      }
    }
    .onAppear {
      VM.getMessages(meetingID: meeting.meetingID)
    }
  }
}

struct ChatMessageCell: View {
  let isFromCurrentUser: Bool
  let sh = UIScreen.main.bounds.height
  var message: messagedto
  var body: some View {
    if isFromCurrentUser {
      HStack {
        Spacer()
        ZStack {
          RoundedRectangle(cornerRadius: 12).foregroundStyle(.green)
          Text(message.message)
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
            Text(message.userEmail).modifier(SubTitle())
          }
          ZStack {
            RoundedRectangle(cornerRadius: 12).foregroundStyle(.gray)
            Text(message.message)
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
