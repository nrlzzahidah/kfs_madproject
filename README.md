# Recipe Finder App

The Recipe Finder app isa mobile app crated with Flutter, across-platform framework for developing native appps. Users can search for recipes using certain keywords and browse recipe details.

The following is a high-level overview of the project:
- **User Authentication**: Firebase Authentication is used for user authentication in the app. Users can create an account by providing an email address and a password, or they can login in to an existing account. Firebase Authentication services handle the authentication procedure.
- **Login and Registration Screens**: The software includes a login page where users can sign in by entering their email address and password. If a person does not already have an account, they can go to the registration screen to establish one.
- Users are led to the **Recipe Search Screen** after they have been authorized. This screen contains a search field where users can type in terms relevant to the recipes they want to find. When they click the "Search" button, the app uses the entered search query to retrieve recipe data from an external API (in this project, TheMealDB API).
- **Recipe Listing**: The searh results are displayed as a list of recipe items in the app. Each item includes a thumbnail image of the recipe as well as the title. Users can view the details of a recipe item by tapping on it.
- The **Recipe Details Screen** display specific information on a selected recipe, such as the recipe's name, thumbnail image, ingredients and instructions. The recipe information is obtained via the external API.

This app shows how to use Flutter with Firebase to perform user authentication and data retrieval. 

## Project Members

| Name                                 | Matric No      |
| ------------------------------------ | -------------- |
| Aisyah Saidah binti Mohd Khalili     | 2014302        |
| Nurul Zahidah binti Jamaludin        | 2011130        |

## Compilation and Running Instructions

To compile and execute the Recipe Finder programme, follow these steps:

1. Install Flutter:
   - Ensure that you have the Flutter SDK installed on your PC. If not, you can use this guide to install Flutter: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

2. Make a new Flutter project:
   - Launch a terminal or command prompt and navigate to the directory where you want to save your project.
   - To start a new Flutter project, use the following command:
     ```
     flutter create recipe_finder
     ```
   - This will generate a new directory called "recipe_finder" that containts the Flutter project structure.

3. Replace the default "lib/main.dart" file:
   - Replace the automatically generated "lib/main.dart" file in your project directory with the updated code from this repository.

4. Update dependencies:
   - In your project directory, open the "pubspec.yaml" file.
   - Add the following packages to the `dependencies` section:
     ```
     dependencies:
       flutter:
         sdk: flutter
       http: ^0.13.6
       firebase_auth: ^4.6.3
       firebase_core: ^2.14.0
     ```
   - Save the file and then execute the following command to retirieve and update the dependencies:
     ```
     flutter pub get
     ```
5. Configure Firebase Authentication:
   - If you haven't already configure, go to [Firebase Console](https://console.firebase.google.com/) and create a new Firebase project.
   - Follow the steps given.
   - For your project, enable the Firebase Authentication service.
   - Obtain the Firebase configuration file (google-services.json for Android or GoogleService-Info.plist for iOS) and save it to the platform's corresponding folders: `android/app` for Android or `ios/Runner` for iOS.

6. Launch the app:
   - Plug in a device or launch an emulator.
   - To create and activate the app on your device/emulator, use the following command:
     ```
     flutter run
     ```
     - The app will be compiled and installed on the device/emulator, and the Recipe Finder app shoudld be visible.

   - To execute the app on a specific device/emulator, use the `-d` flag followed by the device ID. For instance:
     ```
     flutter run -d emulator-2323
     ```
That's all! Using the provided code, you should now be able to compile and run the Recipe Finder app.
