//
//  ItemCard.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 21/01/2021.
//

import SwiftUI

struct ItemCard: View {
    @ObservedObject var item: Item
    var body: some View {
        Text("Item at \(item.timestamp ?? Date.distantPast, formatter: itemFormatter)") // The ?? value is just to work around NavigationLink hanging on to this View and body being run after it was deleted which crashes if it was force unwrapped.
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
