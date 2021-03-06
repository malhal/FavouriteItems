# FavouriteItems
SwiftUI's `@FetchRequest` for CoreData doesn't get enough love so I made this simple demo app to show how easy it is to use.

Run the sample and tap + to add a few items. Tap the items to view the details and then use the toggle in the middle of the screen to mark the item as a favourite. Go back to the list and filter it by favourite using the toggle in the list header.

The `ContentView` has the `onlyFavs` var for the filter (which is saved in User Defaults via `@AppStorage`). When it is toggled, the body runs and `ItemRows` is created again with the new value of `onlyFavs`. In the constructor of `ItemRows` it uses a little known trick to build a dynamic `FetchRequest` based on a predicate and setting it on `_items`.

![Screenshot Favs-off](/Screenshots/Favs-off.png)
![Screenshot Favs-on](/Screenshots/Favs-on.png)
