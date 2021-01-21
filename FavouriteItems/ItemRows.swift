//
//  ItemRows.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 21/01/2021.
//

import SwiftUI

struct ItemRows: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest
    public var items: FetchedResults<Item>

    init(onlyFavs: Bool) {
        var predicate: NSPredicate? = nil
        if(onlyFavs) {
            predicate = NSPredicate(format: "favourite == %d", onlyFavs)
        }
        _items = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], predicate: predicate, animation: .default)
    }
    
    var body: some View {
        ForEach(items) { item in
            NavigationLink(destination: DetailView(item: item)) {
                Label(
                    title: { ItemCard(item:item) },
                    icon: { Image(systemName: item.favourite ? "star.fill" : "star") }
                )
            }
        }
        .onDelete(perform: deleteItems)
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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
