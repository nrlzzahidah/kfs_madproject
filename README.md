# Recipe Finder App

This is a Flutter app that allows users to search for recipes using the MealDB API. Users can enter a search query, fetch recipes based on the query, and view the recipe details. The app also includes user authentication using Firebase Authentication, allowing users to sign in.

## Project Members

| Name                                 | Matric No      |
| ------------------------------------ | -------------- |
| Aisyah Saidah binti Mohd Khalili     | 2014302        |
| Nurul Zahidah binti Jamaludin        | 2011130        |

## Compilation and Running Instructions

Follow these steps to compile and run the Recipe Finder app:

1. Set up Flutter:
   - Make sure you have Flutter SDK installed on your machine. If not, you can follow the Flutter installation guide: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

2. Create a new Flutter project:
   - Open a terminal or command prompt and navigate to the desired directory where you want to create your project.
   - Run the following command to create a new Flutter project:
     ```
     flutter create recipe_finder
     ```
   - This will create a new directory named "recipe_finder" with the Flutter project structure.

3. Replace the default "lib/main.dart" file:
   - Replace the contents of the automatically generated "lib/main.dart" file in your project directory with the updated code provided in this repository.

4. Update dependencies:
   - Open the "pubspec.yaml" file in your project directory.
   - Update the `dependencies` section to include the necessary packages:
     ```
     dependencies:
       flutter:
         sdk: flutter
       http: ^0.13.6
       firebase_auth: ^4.6.3
       firebase_core: ^2.14.0
     ```
   - Save the file and run the following command to fetch and update the dependencies:
     ```
     flutter pub get
     ```

5. Run the app:
   - Connect a device or start an emulator.
   - Run the following command to build and launch the app on your device/emulator:
     ```
     flutter run
     ```
     - The app will be compiled and installed on the device/emulator, and you should see the Recipe Finder app running.

   - If you prefer running the app in a specific device/emulator, you can use the `-d` flag followed by the device ID. For example:
     ```
     flutter run -d emulator-5554
     ```

That's it! You should now be able to compile and run the Recipe Finder app using the provided code.

If you encounter any issues or need further assistance, feel free to reach out.
