import SwiftUI

struct MeetingsView: View {
  @StateObject var VM = MeetingsViewModel()
  @State private var searhcTerm = ""
  @State private var isProfilePresented: Bool = false
  @State private var isCreatePresented: Bool = false
  let sw = UIScreen.main.bounds.width

  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {

        ForEach(VM.meetingResponse.data , id: \.meetingID) { meeting in
          NavigationLink {
            MeetingDetailView(meeting: meeting)
          } label : {
            CardView(meeting: meeting)
          }
        }
//        List($VM.meetings) {
//          NavigationLink {
//            MeetingDetailView(meeting: VM.meetings)
//              .toolbar(.hidden, for: .tabBar)
//          } label: {
//            CardView(meeting: meeting.data)
//          }
//        }.scrollContentBackground(.hidden)
          .refreshable {
            VM.fetchMeetings()
          }
        BottomBarView(isCreatePresented: $isCreatePresented)
      }.navigationTitle("Meetings")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            CustomIconButton(action: {
              isProfilePresented = true
            }, buttonImage: .profileIcon)
              .fullScreenCover(isPresented: $isProfilePresented, content: {
//                ProfileView(currentUser: SessionManager.shared.currentUser!)
                Text("a")
              })
          }
        }

    }.onAppear {
      VM.fetchMeetings()
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
  var body: some View {
    HStack {
      CustomIconButton(action: {}, buttonImage: .addMessage, isNotificationButton: true, notCount: 1) // şimdilik 1
      // TODO: bu butonlar firebaseden datalarla bağlanacak
      Spacer()
      CustomIconButton(action: {
        isCreatePresented = true
      }, buttonImage: .addMeet).fullScreenCover(isPresented: $isCreatePresented, content: {
       // CreateMeetingView()
      })
    }.padding()
  }
}
