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

3. In Xcode add follwoing code at AppDelegate.m file
    ```
     #import <FBSDKCoreKit/FBSDKCoreKit.h>

     - (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString  ,id> *)options {  return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url options:options] 
    ```

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


## Error 

1. 'firebase_analytics' or 'firebase_crashlytics' not found 
    - open terminal and cd to your ios code path  
    - try command 'pod install' and 'pod install--repo-update' in terminal 

2. 'ios 9.0, ios support 12.0'
    - Open ios code in Xcode 
    - Click on runner and see option "Info" -> Deployment Target -> Select 12.0 