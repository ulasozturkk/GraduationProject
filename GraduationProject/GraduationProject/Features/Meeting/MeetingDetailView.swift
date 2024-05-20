import SwiftUI
import MapKit

struct MeetingDetailView: View {
  @Environment(\.dismiss) var dismiss
  let meeting: Meeting
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        Details(meeting: meeting)
          .padding()
      }.navigationTitle(meeting.title)
        .navigationBarTitleDisplayMode(.large)
      
        
    }.navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomBackButton {
            dismiss()
          }
        }
      }
  }
}

struct Details: View {
  let meeting: Meeting
  var body: some View {
    VStack {
      HStack {
        CustomImage(imagename: .clockIcon)
        Text(verbatim: "\(meeting.time)").modifier(SubTitle())
        Spacer()
      }
      HStack {
        CustomImage(imagename: .infoIcon)
        Text("Meeting ID: \(meeting.meetingID)").modifier(SubTitle())
        Spacer()
      }
      HStack{
        CustomImage(imagename: .locationIcon)
        if (meeting.latitude == 0){
          Text(verbatim: "Online \(meeting.meetingLink ?? "some link")").modifier(SubTitle())
        }else {
          ZStack{
            RoundedRectangle(cornerRadius: 12)
              .frame(height: UIScreen.main.bounds.height * 0.4)
            Map()
          }
          
          // MARK: - TODO: LOCATION VARSA BI HARITA GORUNUMU
        }
        Spacer()
      }
      
      HStack(alignment:.top) {
        CustomImage(imagename: .peopleIcon)
        VStack {
          ScrollView{
            ForEach(meeting.attendeeUsersIDs ?? [], id: \.self) { quest in
              Text(quest)
                .modifier(Description(color:Colors.gray.rawValue))
              //TODO: buraya quest isimleri (firebaseden gelecek)
            }
          }
        }
        Spacer()
      }
      HStack{
        CustomIconButton(action: {
          
        }, buttonImage: .messageIcon)
        .padding(.horizontal)
        Text("Messages").modifier(SubTitle())
        
      }
    }
  }
}
