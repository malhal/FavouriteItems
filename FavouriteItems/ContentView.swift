//
//  ContentView.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 01/01/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("OnlyFavs") var onlyFavs = false
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $onlyFavs.animation(), label: {
                    Text("Only Favs")
                })
                ItemRows(onlyFavs: onlyFavs)
            }
            
            .toolbar {
                #if os(iOS)
                //EditButton()
                #endif
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
