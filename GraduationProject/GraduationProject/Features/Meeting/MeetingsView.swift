import SwiftUI

struct MeetingsView: View {
  @StateObject var VM = MeetingsViewModel()
  
  @State private var searhcTerm = ""
  @State private var isProfilePresented: Bool = false
  @State private var isCreatePresented: Bool = false
  @State private var isInvitesPresented: Bool = false
  @State private var notCount : Int = 0
  let sw = UIScreen.main.bounds.width

  var body: some View {
    NavigationStack {
      VStack(alignment: .center) {
        ScrollView{
          ForEach(VM.meetingResponse.data , id: \.meetingID) { meeting in
            NavigationLink {
              MeetingDetailView(meeting: meeting)
            } label : {
              CardView(meeting: meeting)
            }
          }
        }
          .refreshable {
            VM.fetchMeetings()
          }
        Spacer()
        BottomBarView(isCreatePresented: $isCreatePresented,isInvitesPresented: $isInvitesPresented,VM: VM)
      }.navigationTitle("Meetings")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            CustomIconButton(action: {
              isProfilePresented = true
            }, buttonImage: .profileIcon)
              .fullScreenCover(isPresented: $isProfilePresented, content: {
                ProfileView(currentUser: SessionManager.shared.currentServiceUser!)
                Text("a")
              })
          }
        }

    }.onAppear {
      VM.fetchMeetings()
      VM.fetchInvitations()
    }
    .searchable(text: $searhcTerm, prompt: "Search Meetings")
  }
}

struct CardView: View {
  let meeting: Meeting
  let sw = UIScreen.main.bounds.width

  var body: some View {
    ZStack {
      HStack(spacing: 0) {
        Image("profileIcon")
          .resizable()
          .frame(width: sw * 0.15, height: sw * 0.15)
          .clipShape(RoundedRectangle(cornerRadius: 12))
        VStack(alignment: .leading) {
          Text(meeting.title)
            .modifier(SubTitle())
          Spacer()
            .frame(height: 12)
          Text(meeting.meetingID)
            .modifier(Description(color: Colors.gray.rawValue))
        }
        .padding()
        Spacer()

      }.padding(.horizontal)
        .frame(width: sw * 0.9)
    }
    .background(Color(Colors.textfield.rawValue).opacity(0.7))
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}

struct BottomBarView: View {
  @Binding var isCreatePresented: Bool
  @Binding var isInvitesPresented: Bool
   var VM : MeetingsViewModel
  var body: some View {
    HStack {
      CustomIconButton(action: {
        isInvitesPresented = true
      }, buttonImage: .messageIcon, isNotificationButton: true, notCount: VM.userInvitationsResponse.data.count).fullScreenCover(isPresented: $isInvitesPresented, content: {
        MeetingInvitationsView(VM:VM)
      })

      Spacer()
      CustomIconButton(action: {
        isCreatePresented = true
      }, buttonImage: .plusbutton).fullScreenCover(isPresented: $isCreatePresented, content: {
       CreateMeetingView()
      })
    }.padding()
      .onAppear{
        VM.fetchInvitations()
      }
  }
}
