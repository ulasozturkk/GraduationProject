

import SwiftUI

struct MeetingInvitationsView: View {
  @StateObject var VM: MeetingsViewModel
  @State private var selectedIndex = 0
  let titles = ["Meetings", "Friendships"]
  let sw = UIScreen.main.bounds.width
  @Environment(\.dismiss) var dismiss
  var body: some View {
    NavigationStack {
      VStack {
        Picker(selection: $selectedIndex, label: Text("")) {
          ForEach(0 ..< titles.count) { index in
            Text(titles[index]).tag(index)
          }
        }.pickerStyle(.segmented)
          .padding()
        Spacer()
          
        if selectedIndex == 0 {
          if VM.isLoading {
            ProgressView()
          } else {
            MeetingInvitesView(VM: VM)
          }
        } else if selectedIndex == 1 {
          if VM.isLoading {
            ProgressView()
          } else {
            FriendInvitesView(VM: VM)
          }
        }
          
      }.navigationTitle("Meeting Invites")
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            CustomBackButton {
              dismiss()
              VM.fetchMeetings()
            }
          }
          
        }.onAppear {
          VM.fetchInvitations()
          VM.getUsersInvites()
        }
    }
  }
}

struct FriendInvitesView: View {
  var VM: MeetingsViewModel
  let sw = UIScreen.main.bounds.width
  var body: some View {
    ScrollView {
      ForEach(VM.friendRequsestResponse.data, id: \.id) { user in
        ZStack {
          RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.textfieldBackground)
          VStack{
            HStack {
              Image("profileIcon")
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.width * 0.1)
                .cornerRadius(4)
                            
              VStack(alignment: .leading, spacing: 5) {
                Text(user.email)
                  .fontWeight(.semibold)
                  .lineLimit(2)
                  .minimumScaleFactor(0.5)
                Text(user.userID)
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              }.padding(.horizontal)
              Spacer()
            }
            HStack{
              CustomChoiceButton(action: {
                VM.acceptFriend(friendID: user.userID)
              }, isAccept: true)
              Spacer()
              CustomChoiceButton(action: {
                VM.rejectFriend(friendID: user.userID)
              }, isAccept: false)
            }
          }
        }
        .padding(.horizontal)
      }
    }
  }
}

struct MeetingInvitesView: View {
  var VM: MeetingsViewModel
  let sw = UIScreen.main.bounds.width
  var body: some View {
    ScrollView {
      ForEach(VM.userInvitationsResponse.data.indices) { index in
        ZStack {
          RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.textfieldBackground)
          VStack{
            HStack {
              Image("profileIcon")
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.width * 0.1)
                .cornerRadius(4)
                            
              VStack(alignment: .leading, spacing: 5) {
                Text(VM.userInvitationsResponse.data[index].title)
                  .fontWeight(.semibold)
                  .lineLimit(2)
                  .minimumScaleFactor(0.5)
                Text(VM.userInvitationsResponse.data[index].description)
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              }.padding(.horizontal)
              Spacer()
              
            }
            HStack{
              CustomChoiceButton(action: {
                VM.accept(meetingID: VM.userInvitationsResponse.data[index].meetingID)
              }, isAccept: true)
              Spacer()
              CustomChoiceButton(action: {
                VM.reject(meetingID: VM.userInvitationsResponse.data[index].meetingID)
              }, isAccept: false)
            }.padding(.horizontal)
          }
        }
        .padding(.horizontal)
      }
    }
  }
}
