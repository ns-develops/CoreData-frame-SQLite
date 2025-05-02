//
//  Coredata_introApp.swift
//  Coredata-intro
//
//  Created by Natalie S on 2025-05-02.
//

import SwiftUI

@main
struct Coredata_introApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
