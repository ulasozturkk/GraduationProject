
import SwiftUI

struct SignUpView: View {
  @State var isOn: Bool = false
  @State private var isFocused = false
  @StateObject var VM = SignUpViewModel()
  @State var alertPresented: Bool = false

  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        if VM.errorMessage != "" {
          Text(VM.errorMessage)
            .modifier(SubTitle())
            .foregroundStyle(.red)
        }

        CustomTextField(text: $VM.Username, placeHolderText: "Username", systemImage: "person.fill", isSecured: false).onTapGesture {
          self.isFocused = true
        }
        CustomTextField(text: $VM.Email, placeHolderText: "Email", systemImage: "envelope.fill", isSecured: false).onTapGesture {
          self.isFocused = true
        }
        CustomTextField(text: $VM.Password, placeHolderText: "Password", systemImage: "lock.fill", isSecured: true).onTapGesture {
          self.isFocused = true
        }
        CustomTextField(text: $VM.ConfirmPassword, placeHolderText: "Confirm Password", systemImage: "lock.fill", isSecured: true).onTapGesture {
          self.isFocused = true
        }
        CustomToggle(isOn: $isOn, textColor: Colors.gray.rawValue, ToggleText: "I would like to receive your newsletter and other promotional information")
        Spacer()

        CustomButton(buttonText: "Sign Up") {
          VM.signupwhelper()
        }
        .fullScreenCover(isPresented: $VM.changePage, content: {
          TabBar()
        })

        CustomButton(buttonText: "Don't you have an account?", action: {}, isItTextButton: true)
          .padding()
      }

      .onTapGesture {
        // Ekranın herhangi bir yerine dokunulduğunda klavyeyi gizle
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
      .padding()
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomBackButton {}
        }
        ToolbarItem(placement: .principal) {
          Text("Sign Up")
            .modifier(Title())
        }
      }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
  }
}

#Preview {
  SignUpView()
}
