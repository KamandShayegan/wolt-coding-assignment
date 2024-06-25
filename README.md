# wolt

A new Flutter project for Wolt's hiring assignment (developer's notes below) \
__Check demo at: https://youtu.be/j0EsBEPtfLQ__
## Assignment
### Concept
A user is walking around Helsinki city center looking for a place to eat. 

### Input
- List of coordinates that represent the user's location on a timeline.
- Wolt API endpoint that accepts a location and returns a list of venues next to it.

### Task
Displays a list of venues for the current location of the user. The list contains a maximum of 15 venues (when the server response has more it uses the first 15). The current location is taken from the input list and changes every 10 seconds (your app should refresh the list automatically and user\'s location loops after it reaches the end).
Each venue has “Favorite” action next to it. “Favourite” works as a toggle (true/false) and changes the icon depending on the state. The app remembers these states and re-applies them to venues that come from the server again every time the app is launched.

### Data
#### API endpoint:
GET https://restaurant-api.wolt.com/v1/pages/restaurants?lat=60.170187&lon=24.930599

### Coordinates
List of coordinates:
```
coordinates = [
  ["60.170187", "24.930599"],
  ["60.169418", "24.931618"],
  ["60.169818", "24.932906"],
  ["60.170005", "24.935105"],
  ["60.169108", "24.936210"],
  ["60.168355", "24.934869"],
  ["60.167560", "24.932562"],
  ["60.168254", "24.931532"],
  ["60.169012", "24.930341"],
  ["60.170085", "24.929569"],
];
```
### Assets
Favorite (true): https://material.io/tools/icons/?icon=favorite&style=baseline
Favorite (false): https://material.io/tools/icons/?icon=favorite_border&style=baseline
 
 ## Developer\'s Notes

 ### Architecture
 MVVM architecture is used. 
 - `View` handles the rendering of the venue list.
 - `Model` Handles API response JSON objects to turn JSON to Dart objects. (section, item, image, venue, and coordinate)
 - `Modelview` handles the state management (Provider).

 - `Services` handles functionalities such as the timer, api call, local storage,
 and the looper.
 - 'Constants' takes care of immutable values such as API state values and coordinates
- `Components` handles customized components. In this case, only the item component that shows each venue.

### Libraries
- To save the favorite state even after the app is re-launched, `SharedPreferences` is used. Hive is also an alternative, but saving only a list of IDs is trivial enough to use Sharedpref.
- To handle Favorites UI, the SVGs are downloaded and added to the app's assets.
For API calls, the `Dio` library is used. The default HTTP library is an alternative.
- `Provider` is used as state management. Many alternatives exist to implement the state management (BLoC, Riverpod, etc.)

### Logic, Notes, and Future work
- The application extensively uses `async/await` to manage async operations for fetching the storage data, performing API calls, etc. 
- `Stack` is used to show loading on top of the list because 10 seconds is rather short to change the entire screen just to show the loading widget. Also, stack lets the user continue toggle favorites even during the loading state.
- `BaseViewModel` was chosen as a single viewmodel to contain the logic. In case of more functionalities and bigger applications, the ViewModel can be separated into multiple viewmodels to follow _the separation of concerns_ more precisely.
- States of the API were not in the scope of the task, but `loading` and `success` were implemented to show effective loading. Other states can be implemented as well.
- UI was said to be flexible, and a rectangular image was chosen for the images of the venues. Square images are possible to implement. 
- The trailing zeros in "24.936210" do not change the precision or the location being described. Both "24.93621" and "24.936210" point to the same place on the Earth's surface.
- The application does not support counting in the background.

