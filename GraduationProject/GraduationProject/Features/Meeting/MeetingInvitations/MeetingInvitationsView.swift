

import SwiftUI

struct MeetingInvitationsView: View {
  @StateObject var VM : MeetingsViewModel
  @Environment(\.dismiss) var dismiss
    var body: some View {
      NavigationStack {
        VStack {
          ScrollView {
            ForEach(VM.userInvitationsResponse.data,id: \.meetingID) {meeting in
              NavigationLink {
                MeetingDetailView(meeting: meeting)
              } label: {
                  CardView(meeting: meeting)
              }
              HStack(alignment:.center){
                
                CustomChoiceButton(action: {
                  VM.accept(meetingID: meeting.meetingID)
                }, isAccept: true)
                Spacer()
                CustomChoiceButton(action: {
                  VM.reject(meetingID: meeting.meetingID)
                }, isAccept: false)
                
              }.padding(.horizontal)
            }
          }.refreshable {
            VM.fetchInvitations()
          }
        }.navigationTitle("Meeting Invites")
          .toolbar {
            ToolbarItem(placement: .topBarLeading) {
              CustomBackButton {
                dismiss()
                VM.fetchMeetings()
              }
            }
          
          }.onAppear{
            VM.fetchInvitations()
          }
        
      }
    }
}

#Preview {
  MeetingInvitationsView(VM:MeetingsViewModel())
}
