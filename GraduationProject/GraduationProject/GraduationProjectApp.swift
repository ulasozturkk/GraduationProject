//
//  GraduationProjectApp.swift
//  GraduationProject
//
//  Created by macbook pro on 24.03.2024.
//

import SwiftUI

@main
struct GraduationProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
