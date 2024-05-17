import SwiftUI

struct ProfileView: View {
  let sw = UIScreen.main.bounds.width
  let sh = UIScreen.main.bounds.height
  @Environment(\.dismiss) var dismiss
  let currentUser : User
  @StateObject var VM = ProfileViewModel()
  @State var isAddFriendPresented : Bool = false
    
  @State private var selectedIndex = 0
  let titles = ["Friends", "Places"]
    
  var body: some View {
    NavigationView {
      VStack {
        ZStack(alignment: .top) {
          // White background
          Color.white.edgesIgnoringSafeArea(.all)
                    
          // Green background
          Color.green.frame(height: UIScreen.main.bounds.height * 0.3)
            .edgesIgnoringSafeArea(.top)
                    
          Image("profileIcon")
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .alignmentGuide(.top) { d in
              d[.top] + sh * -0.07
            }
        }
                
        VStack(spacing: 10) {
          Text(currentUser.userName ?? "deneme")
            .modifier(Title())
            .foregroundColor(.black)
                    
          Text(currentUser.email)
            .modifier(SubTitle())
            .foregroundColor(.black)
                    
          Picker(selection: $selectedIndex, label: Text("")) {
            ForEach(0..<titles.count) { index in
              
              Text(titles[index]).tag(index)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding(.horizontal)
                    
          Spacer()
                    
          if VM.isLoading {
            ProgressView()
          }else {
            if selectedIndex == 0 {
              if VM.userFriendsResponse.data.count == 0 {
                Text("You Have no friends buddy!").modifier(SubTitle())
              }else {
                List(VM.userFriendsResponse.data, id:\.id) { friend in
                  HStack {
                    Image("profileIcon")
                      .resizable()
                      .scaledToFit()
                      .frame(height: 30)
                      .cornerRadius(4)
                                  
                    VStack(alignment: .leading, spacing: 5) {
                      Text(friend.email)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                      Text(friend.userID)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                  }
                }
              }
              
            }

          }
          Spacer()
        }
        .frame(height: sh * 0.6)
      }.onAppear{
        VM.getUsersFriends()
      }
      .navigationBarItems(leading: Button(action: {
        dismiss()
      }, label: {
        Image(systemName: "chevron.left").foregroundStyle(.white)
      }), trailing: CustomIconButton(action: {
        self.isAddFriendPresented = true
      }, buttonImage: .addfriendIcon,customSize: sw * 0.15).foregroundStyle(.white))
      .fullScreenCover(isPresented: $isAddFriendPresented, content: {
        AddFriendsView()
      })
    }
  }
}

