Flutter firebase authentication 

Firebase Authentication with Flutter

This is a demo project with use of Flutter to Authenticate Firebase User with different methods provided by Firebase.

This project was built using [Social Authentication](https://firebase.flutter.dev/docs/auth/social/).

How to use

1. Create Flutter Project 
  
  A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

2. Create Firebase Project 
   - [Firebase](https://console.firebase.google.com/)

3. Create Android and ios platform from [Firebase](https://console.firebase.google.com/) project setting.

4. Download google-service.json (Add google-service.json file path : android/app/google-services.json) and googleService-info.plist (Add GoogleService-info.plist in Xcode Path : MyApp/GoogleService-info.plist) file and add both file project root folder.

5. Add required dependancy into "pubspec.yaml" 
   * You can see required dependancy from [Social Authentication](https://firebase.flutter.dev/docs/auth/social/).

6. Add "await Firebase.initializeApp()" into your main.dart 

--------------------------------------------------------------------------------------------------------

## Email and Password authentication on [firebase](https://console.firebase.google.com/)

  1. Enable email authentication 
     * Click on your project in [Firebase](https://console.firebase.google.com/) 
     * Select "Authentication" menu you can see right side on top 
     * Select "Sign-in method" and turn on Email/Password

--------------------------------------------------------------------------------------------------------

## Google authentication with firebase
   
  1. Create Android and ios platform from [Firebase](https://console.firebase.google.com/) project setting.
  2. Download google-service.json and googleService-info.plist file and add both file project root folder.
  3. Enable google authentication on [Firebase](https://console.firebase.google.com/).
     * Click on your project in [Firebase](https://console.firebase.google.com/) 
     * Select "Authentication" menu you can see right side on top 
     * Select "Sign-in method" and turn on "Google"

--------------------------------------------------------------------------------------------------------

## Facebook authentication with firebase

  1. Create facebook app using facebook developer account.
  2. Add android and ios platform on [Facebook](https://developers.facebook.com/apps/) app.
  3. Enable facebook authentication on [Firebase](https://console.firebase.google.com/).
     * Click on your project in [Firebase](https://console.firebase.google.com/) 
     * Select "Authentication" menu you can see right side on top 
     * Select "Sign-in method" and turn on "Facebook"
     * Add Facebook App Id & App seceret from [facebook developer account](https://developers.facebook.com/apps)      

--------------------------------------------------------------------------------------------------------     

--------------------------------------------------------------------------------------------------------

## Twitter authentication with firebase

  1. Create twitter app using [twitter developer account](https://developer.twitter.com/en/apps)
  2. Copy & store "Api Key" & "Api Secert Key".
  3. Enable twitter authentication on [Firebase](https://console.firebase.google.com).
     * Click on your project in [Firebase](https://console.firebase.google.com/) 
     * Select "Authentication" menu you can see right side on top 
     * Select "Sign-in method" and turn on "Twitter"
     
--------------------------------------------------------------------------------------------------------     

## Apple authentication with firebase

  1. Register your app in apple store using [apple developer account](https://developer.apple.com)
  2. If you not able to understand properly follow this dependancy [sign_in_with_apple](https://pub.dev/packages/sign_in_with_apple)
  2. Enable Apple authentication on [Firebase](https://console.firebase.google.com/).
     * Click on your project in [Firebase](https://console.firebase.google.com/) 
     * Select "Authentication" menu you can see right side on top 
     * Select "Sign-in method" and turn on "Apple"
     
--------------------------------------------------------------------------------------------------------  

## Phone number authentication with firebase

1.Enable phone number authentication on [Firebase](https://console.firebase.google.com).
     * Click on your project in [Firebase](https://console.firebase.google.com) 
     * Select "Authentication" menu you can see right side on top 
     * Select "Sign-in method" and turn on "Phone Number"


## Setup Guides

1. For setup on ios follow [IOS Guide](lib/IosGuide.md)

2. For setup on android follow [Android Guide](lib/AndroidGuide.md)

--------------------------------------------------------------------------------------------------------     

## To do

- [x] Add Authentication with Email and Password
- [x] Add Authentication with Google
- [x] Add Authentication with Facebook
- [x] Add Authentication with Apple
- [x] Add Authentication with Twitter
- [x] Add Authentication with Phone number