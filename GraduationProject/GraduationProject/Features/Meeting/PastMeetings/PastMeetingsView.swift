

import SwiftUI

struct PastMeetingsView: View {
  @StateObject var VM = PastMeetingsViewModel()
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
          
        }.navigationTitle("Meetings")
          .navigationBarTitleDisplayMode(.large)
          

      }.onAppear{
        VM.fetchMeetings()
      }
    }
}

#Preview {
    PastMeetingsView()
}
