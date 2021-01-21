//
//  FavouriteItemsApp.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 01/01/2021.
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
