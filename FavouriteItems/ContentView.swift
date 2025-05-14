//
//  ContentView.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 01/01/2021.
//

import SwiftUI
import CoreData

extension Item {
    static let onlyFavsPredicate = NSPredicate(format: "favourite = YES")
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @SceneStorage("OnlyFavs") var onlyFavs = false
    
    var fetchRequest: FetchRequest<Item> {
        FetchRequest(sortDescriptors: [SortDescriptor(\Item.timestamp, order: .reverse)],
                     predicate: onlyFavs ? Item.onlyFavsPredicate : nil,
                     animation: .default)
    }
    
    struct ItemRow: View {
        @ObservedObject var item: Item
        
        var body: some View {
            Label {
                Text("Item at \(item.timestamp ?? Date.distantPast, format: Date.FormatStyle(date: .numeric, time: .standard))") // The ?? value is just to work around NavigationLink hanging on to this View and body being run after it was deleted which crashes if it was force unwrapped.
            } icon: {
                Image(systemName: item.favourite ? "star.fill" : "star")
            }
        }
    }

    struct FetchedItems: View {
        let request: FetchRequest<Item>

        var items: FetchedResults<Item> {
            request.wrappedValue
        }
        
        @Environment(\.managedObjectContext) private var viewContext
        
        var body: some View {
            ForEach(items) { item in
                NavigationLink(value: item) {
                    ItemRow(item: item)
                }
            }
            .onDelete { offsets in
                deleteItems(offsets.map { items[$0] })
            }
        }
        
        private func deleteItems(_ items: [Item]) {
            items.forEach(viewContext.delete)
        }
    }
    
    @State var selection: Item?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Toggle("Only Favs", isOn: $onlyFavs.animation())
                FetchedItems(request: fetchRequest)
            }
            .toolbar {
                #if os(iOS)
                    EditButton()
                #endif
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
            }
        } detail: {
            if let selection {
                DetailView(item: selection)
            }
            else {
                Text("Select an item")
            }
        }
    }

    private func addItem() {
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
