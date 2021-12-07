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
    ```
    dependencies {
            classpath 'com.google.gms:google-services:4.3.10'
            classpath 'com.google.firebase:firebase-crashlytics-gradle:2.8.1'
        } 

* Add into (android/app/)build.gradle 
    apply plugin: 'com.google.gms.google-services'
    apply plugin: 'com.google.firebase.crashlytics'

    ```
    defaultConfig {
        
        applicationId "com.example.firebaseauth"
        minSdkVersion 19
        targetSdkVersion 30
        multiDexEnabled true (copy and paste in your project build.gradle)
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    ```
    dependencies {
            implementation platform('com.google.firebase:firebase-bom:29.0.1')
            implementation 'com.google.firebase:firebase-crashlytics'
            implementation 'com.google.firebase:firebase-analytics'
            implementation "androidx.multidex:multidex:2.0.1"
            implementation 'com.facebook.android:facebook-android-sdk:12.1.0' (for facebook)
        } 
        
## Email and Password authentication with firebase

1. Enable Email/Password Auth on [Firebase](https://console.firebase.google.com/).
    - No requirements of any Android studio setup if you already performed a steps of firebase console while adding an app.

## Google authentication with firebase

1. Follow the setup guide of [Firebase](https://console.firebase.google.com/) for firebase setup.
2. Follow the social authentication [Google](https://firebase.flutter.dev/docs/auth/social#google) for google sign setup.

## Facebook authentication with firebase

1. Follow the steps of [Facebook developer console](https://developers.facebook.com/apps/).
    - Perform steps 2.3,2.4, 3 to 6 of setup guide of [Facebook](https://developers.facebook.com/apps/).
2. Follow the social authentication [Facebook](https://firebase.flutter.dev/docs/auth/social#facebook) for facebook sign setup.    

## Twitter authentication with firebase

1. Login/Signup in your [twitter developer account]("https://developer.twitter.com/en/apps")
2. Click Create app
3. Set your app name then copy & store "Api Key" & "Api Secert Key".
4. Follow the social authentication [Twitter](https://firebase.flutter.dev/docs/auth/social#facebook) for facebook sign setup.    
5. Open [twitter_login]("https://pub.dev/packages/twitter_login") and read steps after apply into code
6. Add Callback Url schemes in AndroidManifest.xml file in Xcode
    ```
    <intent-filter>
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <!-- Accepts URIs that begin with "example://gizmos” -->
  <!-- Registered Callback URLs in TwitterApp -->
  <data android:scheme="CALLBACK_SCHEMES"
        android:host="gizmos" /> <!-- host is option -->
</intent-filter>

## Apple authentication with firebase

  1. Register your app in apple store using [apple developer account]("https://developer.apple.com/")
  2. If you can not able to understand properly follow this dependancy [sign_in_with_apple]("https://pub.dev/packages/sign_in_with_apple")
  3. Enable Apple authentication on [Firebase](https://console.firebase.google.com/).
     * Click on your project in [Firebase](https://console.firebase.google.com/) 
     * Select "Authentication" menu you can see right side on top 
     * Select "Sign-in method" and turn on "Apple"

## Phone number authentication with firebase
  1. Enable Phone Auth on Firebase.
      * No requirements of any Android studio setup if you had already performed steps of google auth.
  2. Follow the [Phone Authentication](https://firebase.flutter.dev/docs/auth/phone) for phone auth setup.

## Error 
1. .Dexpath file 
   - Open android studio
   - Add -> implementation "androidx.multidex:multidex:2.0.1" -> in android app/build.gradle
   - Add -> multiDexEnabled true -> to in android app/build.gradle
     defaultConfig{
       multiDexEnabled true
    }

2. current minSdkVersion 16 required minSdkVersion 19    
   - Open android studio -> Open app/build.gradle 
    
     defaultConfig {
        applicationId "com.example.firebaseauth"
        minSdkVersion 19 (replace this line 'minSdkVersion 16' to 'minSdkVersion 19')
        targetSdkVersion 30
        multiDexEnabled true
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }