

import SwiftUI

struct TabBar: View {
  var body: some View {
    TabView {
//      MeetingsView()
//        .tabItem { Label("Meetings", systemImage: "calendar") }
//      PastMeetingsView()
//        .tabItem { Label("Past Meetings", systemImage: "calendar.badge.checkmark") }
//
//      SettingsView()
//        .tabItem { Label("Settings", systemImage: "gearshape") }
    }.navigationBarBackButtonHidden(true)
      .tint(Color(Colors.green.rawValue))
      .background(Color(Colors.textfield.rawValue))
  }
}

#Preview {
  TabBar()
}
