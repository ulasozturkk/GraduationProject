
import MapKit
import SwiftUI

struct CreateMeetingView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject var VM = CreateMeetingViewModel()
  @State var alertPresented: Bool = false
  @State var isMapDetailPresented: Bool = false
  
  let sh = UIScreen.main.bounds.height
  let sw = UIScreen.main.bounds.width
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .center) {
        CustomTextField(text: $VM.Title, placeHolderText: "Meet Title", systemImage: "pencil", isSecured: false)
        CustomTextField(text: $VM.description, placeHolderText: "Meet Description", systemImage: "pencil", isSecured: false)
        HStack{
          if VM.invitedUserList.isEmpty {
            Button(action: {
              alertPresented = true
            }) {
              Image(systemName: "person.badge.plus")
                .foregroundColor(.white)
                .padding()
                .background(Color(Colors.green.rawValue))
                .cornerRadius(sw / 2)
            }
            .popover(isPresented: $alertPresented) {
              UserListView(VM: VM)
            }
          } else {
            Button(action: {
              alertPresented = true
            }) {
              HStack {
                Text("\(VM.invitedUserList.count) Kullanıcı")
                  .foregroundColor(.white)
                Image(systemName: "pencil")
                  .foregroundColor(.white)
              }
              .padding()
              .background(Color(Colors.green.rawValue))
              .cornerRadius(sw / 2)
              .popover(isPresented: $alertPresented) {
                UserListView(VM: VM)
              }
            }
          }
          Spacer()
          
          DatePicker("", selection: $VM.MeetingDate, in: Date.now..., displayedComponents: [.date, .hourAndMinute])
            .labelsHidden()
            .frame(height: 45)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1))
        }
      }.onAppear {
        VM.getAllUsers()
      }
      CustomToggle(isOn: $VM.isOnline, textColor: Colors.black.rawValue, ToggleText: "Online Meeting")
      
      ScrollView {
        VStack(alignment: .center, spacing: 30) {
          if VM.isOnline != false {
            HStack {
              Spacer()
              VStack {
                CustomButton(buttonText: "Select Location") {
                  isMapDetailPresented = true
                }.sheet(isPresented: $isMapDetailPresented, content: {LocationDetailView(VM:VM)})
                Map(initialPosition: VM.meetingCameraPosition) {
                  Annotation("meeting location", coordinate: CLLocationCoordinate2D(
                    latitude: VM.latitude ?? 0 ,
                    longitude: VM.longitude ?? 0
                  )) {
                    Image(systemName: "star.circle")
                      .resizable()
                      .foregroundStyle(.red)
                      .frame(width: 44, height: 44)
                      .background(.white)
                      .clipShape(.circle)
                  }
                }
                .onTapGesture {
                  print($VM.Title)
                }
                .frame(width: sw * 0.7, height: sw * 0.6)
              }
              
              Spacer()
            }
            
          } else {
            CustomTextField(text: $VM.meetingLinkString, placeHolderText: "Meeting link:", systemImage: "link", isSecured: false)
          }
          
          CustomButton(buttonText: "Create Meeting") {
            VM.createMeeting { result in
              switch result {
              case .success(let res):
                print("created")
                dismiss()
              case .failure(let err):
                print(err)
              }
              print(VM.latitude,VM.longitude)
              if VM.isMeetingCreated == true {
                dismiss()
              }
            }
          }.padding()
        }
        .onTapGesture {
          // Ekranın herhangi bir yerine dokunulduğunda klavyeyi gizle
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .padding()
        .navigationTitle("Create Meeting")
        //                .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            CustomBackButton {
              dismiss()
            }
          }
        }
      }.padding(.horizontal)
        .padding(.top, 20)
    }.padding()
  }
  
  
}
struct UserListView: View {
  @StateObject var VM: CreateMeetingViewModel
  @Environment(\.dismiss) var dismiss
  let sw = UIScreen.main.bounds.width
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack {
          ForEach(VM.userlist.data.indices, id: \.self) { index in
            if index < VM.invitedUserCheckList.count { // Check if index is valid
              ZStack {
                HStack {
                  Text(VM.userlist.data[index].email)
                  Spacer()
                  Image(systemName: VM.invitedUserCheckList[index] ? "checkmark.square.fill" : "square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(Colors.green.rawValue))
                    .onTapGesture {
                      VM.invitedUserCheckList[index].toggle()
                    }
                }
              }
            }
          }
        }
        .padding()
      }
      .navigationTitle("Invite Users")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Save") {
            VM.inviteUsers()
            dismiss()
          }
          .modifier(SubTitle())
        }
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            if VM.invitedUserCheckList.contains(true) {
              VM.removeAllSelected()
            } else {
              VM.toggleAll()
            }
          }) {
            Text(VM.invitedUserCheckList.contains(true) ? "Remove All" : "All Select")
          }
        }
      }
    }
  }
}
