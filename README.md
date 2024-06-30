# Task Manager App
This repository is based on Flutter clean-code clean-architecture principles.

# Features and Functions:
Login - SignUp - logout using Firebase Auth
Projects : user can browse/create/Delete/Update a Project - assign members to the project
Tasks: each project containes tasks, user can browse/create/Delete/Update a Project Task.
User can mark As Done tasks (only if user is an assignee)
User can Delete a task (only if user is an assignee)
Project Contains Analysis: Pending/completed tasks Pie chart, A Liner progress indicator that states the overall completion of the tasks
BLoC as my app state managment
FireStore as My DB


## SDK and Flutter
Flutter 3.19.6 
Dart 3.3.4


# Contents 

* Singleton file to ensure that the app has one single instance of something, for example, token, user entity, preferences, etc.
* FireStore_services file for handling all firestoreDB calls
* each feature has a usecase that implements a BaseUseCase Abstarct class for a better and more unified code structre.
* Contains a service locator file that acts as a dependency injection agent to help instantiate an instance of something, for example, a singleton, a module, a remote data source, or a use-case.
* State renderer to render loading/error/success states dialogs and pop-ups.
* This contains an error handler to handle different status responses.
* Contains a resource manager folder to help with different project resources like routes, colors, sizes, paddings, assets, fonts, text styles.
* App_Prefs file that has saveDataToSharedPrefs and getDataFromSharedPrefs, deleteDataToSharedPref, and clear methods (to handle all shared prefs data).
* Constants file contains all predefined constants files like API URLs and BaseUrls and Collection names.
* Some basic string, int, double, dateTime extensions.
* A validator file that validates inputs like phone numbers, emails, passwords, confirm password fields.
* Asset folder that has sounds, JSON, SVGs, images folder.
* MyBlocObserver to easily observe any changes for Blocs.

# Application ScreenShots 
![Image 1](App%20screenshots/1.png)
![Image 2](App%20screenshots/2.png)
![Image 3](App%20screenshots/3.png)
![Image 4](App%20screenshots/4.png)
![Image 5](App%20screenshots/5.png)
![Image 6](App%20screenshots/6.png)
![Image 7](App%20screenshots/7.png)
![Image 8](App%20screenshots/8.png)
![Image 9](App%20screenshots/9.png)
![Image 10](App%20screenshots/10.png)
![Image 11](App%20screenshots/11.png)
![Image 12](App%20screenshots/12.png)
![Image 13](App%20screenshots/13.png)