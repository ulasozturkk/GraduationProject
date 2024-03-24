

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
  {
    FirebaseApp.configure()
    return true
  }
}

@main
struct GraduationProjectApp: App {
  let persistenceController = PersistenceController.shared
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
