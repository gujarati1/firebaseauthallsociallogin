# Flutter IOS Setup

This is guide you to Xcode setup while enabling Flutter Firebase Authentication.

=> Add GoogleService-info.plist in Xcode 
  Path : MyApp/GoogleService-info.plist

## Email and Password authentication with firebase

1. Enable Email/Password Auth on [Firebase](https://console.firebase.google.com/). 
    - No requirements of any Xcode setup.

## Facebook authentication with firebase

1. Follow the steps of [Facebook developer console](https://developers.facebook.com/apps/).
    - Perform steps 2,3,4 of setup guide of [Facebook](https://developers.facebook.com/apps/).
    
2. Follow the social authentication [Facebook](https://firebase.flutter.dev/docs/auth/social#facebook) for facebook sign in setup. 

## Google authentication with firebase

1. Follow the setup guide of [Firebase](https://console.firebase.google.com/) for firebase setup.

2. Follow the social authentication [Google](https://firebase.flutter.dev/docs/auth/social#google) for google sign in setup.

3. Add URL schemes in Info.plist file in Xcode
    ```
    <key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string><YOUR_REVERSE_CLIENT_ID></string>
			</array>
		</dict>
	</array>

## Twitter authentication with firebase

1. Login/Signup in your [twitter developer account](https://developer.twitter.com/en/apps)
2. Click Create app
3. Set your app name then copy & store "Api Key" & "Api Secert Key".
4. Follow the social authentication [Twitter](https://firebase.flutter.dev/docs/auth/social#facebook) for facebook sign in setup.    
5. Open [twitter_login]("https://pub.dev/packages/twitter_login") and read steps after apply into code
6. Add Callback Url schemes in Info.plist file in Xcode
    ```
    <key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>CALLBACK_SCHEMES</string>
			</array>
		</dict>
	</array>

## Apple authentication with firebase

  1. Register your app in apple store using [apple developer account](https://developer.apple.com)
  2. If you can not able to understand properly follow this dependancy [SignInWithApple](https://pub.dev/packages/sign_in_with_apple)
  3. Enable Apple authentication on [Firebase](https://console.firebase.google.com/).
     * Click on your project in [Firebase](https://console.firebase.google.com/) 
     * Select "Authentication" menu you can see right side on top 
     * Select "Sign-in method" and turn on "Apple"

## Phone number authentication with firebase

   1. Enable Phone Auth on Firebase.
      * No requirements of any Xcode setup if you had already added URL schmes otherwise follow the step 2 of google auth.
   2. Follow the [Phone Authentication](https://firebase.flutter.dev/docs/auth/phone) for phone auth setup.

## Error 

1. 'firebase_analytics' or 'firebase_crashlytics' not found 
    - open terminal and cd to your ios code path  
    - try command 'pod install' and 'pod install--repo-update' in terminal 

2. 'ios 9.0, ios support 12.0'
    - Open ios code in Xcode 
    - Click on runner and see option "Info" -> Deployment Target -> Select 12.0 