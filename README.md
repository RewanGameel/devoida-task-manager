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
<div style="display: flex; flex-wrap: wrap; gap: 20px;">
    <img src="App%20screenshots/1.png" alt="Image 1" style="width: 230px;">
    <img src="App%20screenshots/2.png" alt="Image 2" style="width: 230px;">
    <img src="App%20screenshots/3.png" alt="Image 3" style="width: 230px;">
    <img src="App%20screenshots/4.png" alt="Image 4" style="width: 230px;">
    <img src="App%20screenshots/5.png" alt="Image 5" style="width: 230px;">
    <img src="App%20screenshots/6.png" alt="Image 6" style="width: 230px;">
    <img src="App%20screenshots/7.png" alt="Image 7" style="width: 230px;">
    <img src="App%20screenshots/8.png" alt="Image 8" style="width: 230px;">
    <img src="App%20screenshots/9.png" alt="Image 9" style="width: 230px;">
    <img src="App%20screenshots/10.png" alt="Image 10" style="width: 230px;">
    <img src="App%20screenshots/11.png" alt="Image 11" style="width: 230px;">
    <img src="App%20screenshots/12.png" alt="Image 12" style="width: 230px;">
    <img src="App%20screenshots/13.png" alt="Image 13" style="width: 230px;">
    <img src="App%20screenshots/14.png" alt="Image 14" style="width: 230px;">
    <img src="App%20screenshots/15.png" alt="Image 15" style="width: 230px;">
    <img src="App%20screenshots/16.png" alt="Image 16" style="width: 230px;">
    <img src="App%20screenshots/17.png" alt="Image 17" style="width: 230px;">
</div>