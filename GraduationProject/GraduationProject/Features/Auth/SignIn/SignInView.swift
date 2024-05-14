
import SwiftUI

struct SignInView: View {
  @StateObject var VM = SignInViewModel()
  @State private var showAlert = false
  @State private var showingSignUp = false
    
  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        if VM.errorMessage != "" {
          Text(VM.errorMessage)
            .modifier(SubTitle())
            .foregroundStyle(.red)
        }
                
        CustomTextField(text: $VM.email, placeHolderText: "E-Mail", systemImage: "envelope.fill", isSecured: false)
        CustomTextField(text: $VM.password, placeHolderText: "Password", systemImage: "lock.fill", isSecured: true)
        Spacer()
                
        CustomButton(buttonText: "Sign In") {
          VM.signInWHelper()
          
          if VM.errorMessage != "" {
            showAlert = true
          }
        }
        .alert(isPresented: $showAlert) {
          Alert(title: Text("Error"), message: Text(VM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .fullScreenCover(isPresented: $VM.changePage) {
          TabBar()
        }
                
        CustomButton(buttonText: "Don't you have an account?", action: {
          showingSignUp = true
        }, isItTextButton: true)
          .padding()
          .fullScreenCover(isPresented: $showingSignUp, content: {
            SignUpView()
          })
      }
      .padding()
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomBackButton {}
        }
        ToolbarItem(placement: .principal) {
          Text("Sign In")
            .modifier(Title())
        }
      }
      .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    .onTapGesture {
      // Ekranın herhangi bir yerine dokunulduğunda klavyeyi gizle
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
  }
}

#Preview {
  SignInView()
}
