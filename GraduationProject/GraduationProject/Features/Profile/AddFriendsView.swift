
import SwiftUI

struct AddFriendsView: View {
  @StateObject var VM = ProfileViewModel()
  @StateObject var CVM = CreateMeetingViewModel()
  @Environment(\.dismiss) var dismiss
  var body: some View {
    NavigationStack {
      VStack {
        UserAddListView(VM: CVM, PVM: VM)
      }
    }.navigationTitle("Meeting Invites")
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomBackButton {
            dismiss()
          }
        }
          
      }.onAppear {
        CVM.getAllUsers()
      }
  }
}

struct UserAddListView: View {
  @StateObject var VM: CreateMeetingViewModel
  @StateObject var PVM: ProfileViewModel
  @Environment(\.dismiss) var dismiss
  let sw = UIScreen.main.bounds.width
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack {
          ForEach(VM.userlist.data.indices, id: \.self) { index in
            ZStack {
              RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.textfieldBackground)
              HStack {
                Image("profileIcon")
                  .resizable()
                  .scaledToFit()
                  .frame(height: sw * 0.1)
                  .cornerRadius(4)
                              
                VStack(alignment: .leading, spacing: 5) {
                  Text(VM.userlist.data[index].email)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                  Text(VM.userlist.data[index].email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }.padding(.horizontal)
                Spacer()
                CustomIconButton(action: {
                  PVM.sendFriendshipRequest(requestUserID: VM.userlist.data[index].userID)
                  
                }, buttonImage: .addfriendIcon, customSize: sw * 0.2)
              }
            }
          }
        }
        .padding()
      }
      .navigationTitle("All Users")
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomBackButton(action: {
            dismiss()
          })
          .modifier(SubTitle())
        }
      }
    }
  }
}

#Preview {
  AddFriendsView()
}
