

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
                  PastCardView(meeting: meeting, VM: VM,review: VM.reviewPoint)
              }
            }
          }
            .refreshable {
              VM.fetchMeetings()
            }
          Spacer()
          
        }.navigationTitle("Past Meetings")
          .navigationBarTitleDisplayMode(.large)
          

      }.onAppear{
        VM.fetchMeetings()
      }
    }
}

#Preview {
    PastMeetingsView()
}

struct PastCardView: View {
  let meeting: Meeting
    let VM: PastMeetingsViewModel
  var review : Double = 0
  let sw = UIScreen.main.bounds.width

  var body: some View {
      VStack {
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
          ZStack{
              RoundedRectangle(cornerRadius: 12)
                  .frame(width: sw * 0.9,height: sw * 0.2)
                  .foregroundStyle(.textfieldBackground)
              
              HStack{
                  StarView(rating: review) { rating in
                      VM.reviewPoint = rating
                  
              }
                  CustomIconButton(action: {
                      VM.reviewMeeting(meetingID: meeting.meetingID)
                  }, buttonImage: .saveicon)
              
                  
              }
          }
      }
    .background(Color(Colors.textfield.rawValue).opacity(0.7))
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}
struct StarView: View {
    let rating: Double
    let maxRating: Int = 5
    let onRatingChanged: (Double) -> Void

    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1) { index in
                Image(systemName: self.starType(for: index))
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        self.onRatingChanged(Double(index))
                    }
                    .font(.title)
            }
            
        }
    }

    private func starType(for index: Int) -> String {
        let adjustedIndex = Double(index)
        if adjustedIndex <= rating {
            return "star.fill"
        } else if adjustedIndex <= rating + 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}
