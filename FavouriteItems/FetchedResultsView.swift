//
//  FetchedResultsView.swift
//  FavouriteItems
//
//  Created by Malcolm Hall on 22/01/2025.
//

import SwiftUI
import CoreData

struct FetchedResultsView<Content, Result>: View where Content: View, Result: NSFetchRequestResult {
    @FetchRequest var results: FetchedResults<Result>
    let content: ((FetchedResults<Result>) -> Content)
    
    init(request: FetchRequest<Result>, @ViewBuilder content: @escaping (FetchedResults<Result>) -> Content) {
        self._results = request
        self.content = content
    }
    
    var body: some View {
        content(results)
    }
}
