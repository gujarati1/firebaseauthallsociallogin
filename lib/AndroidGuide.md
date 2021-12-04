# Flutter Android Setup 

This is guide you to Android Studio setup while enabling Flutter Firebase Authentication.

- Make sure await Firebase.initializeApp() into your main() lib/main.dart 

  Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); (Add this line into main.dart file) 
  await Firebase.initializeApp();  (Add this line into main.dart file)
  runApp(const MyApp());
}

* Add google-service.json file 
   path : android/app/google-services.json

* Add into (root)build.gradle 

    dependencies {
            classpath 'com.google.gms:google-services:4.3.10'
            classpath 'com.google.firebase:firebase-crashlytics-gradle:2.8.1'
        } 

* Add into (android/app/)build.gradle 
    apply plugin: 'com.google.gms.google-services'
    apply plugin: 'com.google.firebase.crashlytics'

    defaultConfig {
        
        applicationId "com.example.firebaseauth"
        minSdkVersion 19
        targetSdkVersion 30
        multiDexEnabled true (copy and paste in your project build.gradle)
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    dependencies {
            implementation platform('com.google.firebase:firebase-bom:29.0.1')
            implementation 'com.google.firebase:firebase-crashlytics'
            implementation 'com.google.firebase:firebase-analytics'
            implementation "androidx.multidex:multidex:2.0.1"
        } 
        
## Email and Password authentication with firebase

1. Enable Email/Password Auth on [Firebase](https://console.firebase.google.com/).
    - No requirements of any Android studio setup if you already performed a steps of firebase console while adding an app.

## Google authentication with firebase

1. Follow the setup guide of [Firebase](https://console.firebase.google.com/) for firebase setup.
2. Follow the social authentication [Google](https://firebase.flutter.dev/docs/auth/social#google) for google sign in setup.

## Facebook authentication with firebase

1. Follow the steps of [Facebook developer console](https://developers.facebook.com/apps/).
    - Perform steps 2.3,2.4, 3 to 6 of setup guide of [Facebook](https://developers.facebook.com/apps/).
2. Follow the social authentication [Facebook](https://firebase.flutter.dev/docs/auth/social#facebook) for facebook sign in setup.    


