### ParkingOps

An app made using Flutter.
> In progress.

#### OBJECTIVE :

* To make parking lots more efficient.
* Reduce chances of theft significantly.
* Reduce the time taken for check-in and check-out of vehicles.
* Display the available parking spaces in a particular parking lot.
* Display the necessary info and the current status of the parking lot.
* Save paper and go digital.

#### FUNCTIONS OF THE APP :

* A smart parking system wherein the driver can check-in and check-out via displaying a unique QR code.
* The system is implemented within an application made using Flutter.
* User needs to either Sign-In or Sign-Up for using the app and his information is to be stored and verified using the Cloud FireBase database and FirebaseAuth Authentication.
* Once the user has logged in, he can generate his unique QR code for displaying at the parking lot and either check-in or check-out.
* Unique QR codes to be generated for each user and each parking lot and their information should be stored in a database using Cloud Firestore.
* Once the user gets his QR code scanned and checks in, his data is stored in a dynamic database using Cloud Firestore and the details of the parking lot and available parking spots in the parking lot are displayed in the app.
* Now, only the user who has checked-in can check out that particular vehicle. During check-out, compare the user data with the already stored data and check-out only if match is found and then delete that entry.

#### HOW TO USE :

* Clone the repository locally using `git clone https://github.com/aashish-g03/ParkingOps`.
* Open Android Studio(version 2.3 and above) with Flutter and Dart plug-ins installed.
* Open the cloned project.
* Browse to **pubspec.yaml** file in the **login_page** folder and use the `pub get` command on the dependencies to download and install them.
> You may use pub get directly too. This is to look at the plug-ins which need to be installed for this app.
* Sync the gradles.
> To sync the gradles in Android Studio, right click on the Android folder in your Flutter project. Navigate to the "Flutter" option and select "Open for editing in Android Studio". Once it opens, sync will start automatically. You may also click on the gradle-build icon present on the top panel.
* Do configurations if necessary(Use `main.dart` as the Dart EntryPoint).
* Open AVD Manager and setup a virtual device(Google Pixel 3A preferred).
* Run the app.
* The app will be built and get installed automatically if everything is correct.
> While running for the first time, `Gradle task 'assembleDebug'...` might take a little time. 

#### IMPORTANT :

* Firebase login and auth are now complete, so new users can sign up and existing users can log in using their registered email and password. The database is hosted at the Firebase console at console.firebase.google.com.
* The user can log out by navigating to the _settings_ page and clicking on the _Log out_ button.
* The QR code generated for each user will be unique. This is so because the user's unique Firebase User ID is being used as the QR text as of now. Since every user will have a unique user ID, the code code generated for each user will be unique too. The user doesn't have the privilege to alter the QR code.
* The QR code generated by the user needs to be scanned at the parking facility and his data will be stored in a database.
* Make necessary changes in the package names and elsewhere if you intend to change the name of any class or Dart file.

