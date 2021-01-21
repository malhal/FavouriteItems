//
//  DetailView.swift
//  SwiftData
//
//  Created by Malcolm Hall on 21/01/2021.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        VStack {
            ItemCard(item: item)
            Toggle(isOn: $item.favourite, label: {
                Text("Is Favourite")
            })
        }
        .padding()
        .onDisappear {
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
