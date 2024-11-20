# AllMoves: The Customizable Exercise Tracking App

## Running AllMoves

### Prerequisites

To run the current SnapShot of AllMoves you will need:

1. [Flutter Installed](https://docs.flutter.dev/get-started/install)
2. [Flutter app development set up on your specific platform](https://docs.flutter.dev/get-started/install)
3. A Computer-native Flutter device to run the application (Windows or Mac)
   - This is becuase saving custom Templates and Exercises relies on reading and writing from a JSON file (incredible program design, I know)
   - (Though, the app and all of it's features will still run on any platform listed using `flutter devices`)

### Running the application

1. After cloning the repository, open the command line and navigate to the root directory of the repository
2. run `flutter run -d {device}`

> Alternatively, if you have Flutter set up in VSCode or Android Studio, you *should* just be able to launch it as you normally would

## State of the app (as of 11/21/24)

### Basic app structure and navigation

- basic structure is done, following the Flutter Material design patterns and utilizing a scaffold structure throughout the app
- navigation between main screens is done using the bottom navigation bar, while inner-screen naviagtion is done with buttons and redirects
- users are able to visit each of the main views and navigate within those views

### Templates

- users are able to view and search for templates in both the templates view and when starting a workout
- template creation is entirely customizable, allowing users to add any exercise with any amount of sets
- templates can even be saved between sessions, reading / writing from a JSON file
- The is no implementation to allow users to give each template an image or icon
- Templates made by the user currently cannot be edited again, but this functionality should be done with the Beta

### Exercises

- exercises can be searched for and added to templates in both template builder mode and workout mode
- excises can be created in both modes as well, specifying name and which attributes they'd like to track
- support for images associated with each exercise is intended to come with the Beta, but depending on need we may pivot to a more convient design

### Home Page

- home view has all of panned design elements, including workout schedule, achievments and goals
- after user feedback, we have moved starting a workout from the home view into its own view / tab
  - previously, selecting the start workout button on either the header of home or the bottom nav bar whould display the selection for "Log Workout Live" or "Log Previous" directly on home
  - we have devided to give it its own view for clairity and a better user experience

### Workouts and Workout Logging

- logging workouts is nearly feature complete, allowing users to select a template, add exercises, add notes to their exercises, fill out their sets, and complete their workout
- what has yet to be done:
  - design-wise, we plan on making each exercise in the template closer to how they're displayed in template builder, which will be implemented in Beta
  - we have a plan for how to design adding tags to an exercise
    -  selecting the "Add Tags" button on a workout will slide allow you to select different tags (and potentially create custom tags)
  - we also need to tweak designs to better support logging different types of exercises, as we have mostly been testing with weight lifting
  - once viewing stats has been futher implemented, conntect workouts to those stats can be finalized

### Viewing Stats

- stats has not yet been implemented in any capacity, as being able to log and complete workouts has been our highest priority
- by the Beta, we plan to have the stats page fully finished, allowing individual workouts to be viewed, goals to be set, etc.
  - at the very least, the UI of this page will be done