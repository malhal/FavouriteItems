//
//  FetchedResultsView.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 22/01/2025.
//

import SwiftUI
import CoreData

struct FetchedResultsView<Content: View, Result>: View where Result: NSFetchRequestResult {
    let request: FetchRequest<Result>
    @ViewBuilder let content: (FetchedResults<Result>) -> Content
    
    var body: some View {
        content(request.wrappedValue)
    }
}
