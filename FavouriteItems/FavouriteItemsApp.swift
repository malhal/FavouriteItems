//
//  FavouriteItemsApp.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 01/01/2021.
//

import SwiftUI

@main
struct FavouriteItemsApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        let viewContext = PersistenceController.shared.container.viewContext
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}
