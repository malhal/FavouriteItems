//
//  DetailView.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 21/01/2021.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var item: Item

    var body: some View {
        VStack {
            Text("Item at \(item.timestamp ?? Date.distantPast, format: Date.FormatStyle(date: .numeric, time: .standard))")
            Toggle("Is Favourite", isOn: $item.favourite)
        }
        .padding()
    }
}
