# clean-flutter-base-project
This repository is based on Flutter clean-code clean-architecture principles. It contains only the necessary folders, libraries, files, and extensions to help kickstart any Flutter app.

## SDK and Flutter
Flutter 3.19.6 
Dart 3.3.4
Created on 3 May 2024

# Contents 
* Dio factory file to handle APIs and their endpoints, headers, options, params, or paths, and on error and on response timeouts.
* Singleton file to ensure that the app has one single instance of something, for example, token, user entity, preferences, etc.
* Contains a service locator file that acts as a dependency injection agent to help instantiate an instance of something, for example, a singleton, a module, a remote data source, or a use-case.
* State renderer to render loading/error/success states dialogs and pop-ups.
* This contains an error handler to handle different status responses.
* Contains a resource manager folder to help with different project resources like routes, colors, sizes, paddings, assets, fonts, text styles.
* Some basic widgets like text fields and text fields with title, custom buttons, custom grid view, custom app bar, custom shimmering loader.
* App_Prefs file that has saveDataToSharedPrefs and getDataFromSharedPrefs, deleteDataToSharedPref, and clear methods (to handle all shared prefs data).
* Constants file contains all predefined constants files like API URLs and BaseUrls and others.
* Some basic string, int, double extensions.
* A validator file that validates inputs like phone numbers, emails, passwords, confirm password fields.
* Asset folder that has sounds, JSON, SVGs, images folder.
* Network folder contains app_api to act as an AppServiceClient for making HTTP requests to a RESTful API with Dio.
* MyBlocObserver to easily observe any changes for Blocs.
