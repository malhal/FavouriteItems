//
//  SwiftDataApp.swift
//  SwiftData
//
//  Created by Malcolm Hall on 04/12/2020.
//

import SwiftUI

@main
struct SwiftDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
