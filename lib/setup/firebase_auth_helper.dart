import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_all_social/constant/constant.dart';
import 'package:firebase_auth_all_social/pref/shared_pref.dart';
import 'package:firebase_auth_all_social/setup/database/data_store.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

class FirebaseAuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

//SIGN UP METHOD
  Future<String?> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHODJ
  Future<String?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static String fbAppID = "758169682249434";

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    await FacebookAuth.instance.logOut();
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
        apiKey: "qPUHtai4VWW5N11cI5ZtXmS84",
        apiSecretKey: "7h8fXCpeeqaJdIGYahSNkcK36hQiHor1t8fUGEaW1AOETLG7dg",
        redirectURI: 'firebase-twitter-login-auth://');

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken.toString(),
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with

    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    Constant.appleToken = oauthCredential.idToken!;
    Constant.fullname =
        '${appleCredential.givenName} ${appleCredential.familyName}';
    String email = '${appleCredential.email}';
    // print("$displayName - $userEmail");
    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  //SIGN OUT METHOD
  Future<void> signOut(BuildContext context) async {
    String? loginType = await getPrefStirngData(Constant.loginType);
    if (loginType == "email") {
      await FirebaseAuth.instance.signOut();
    }
    if (loginType == "google") {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
    }
    if (loginType == "facebook") {
      await FacebookAuth.i.logOut();
      await FirebaseAuth.instance.signOut();
    }
  }
}

loginWithEmail({
  required BuildContext context,
  required String email,
  required String password,
  required Function(String value) onSuccess,
  required Function(String value) onError,
}) {
  DatabaseStore databaseStore = DatabaseStore();
  databaseStore.firebaseInit();

  FirebaseAuthHelper()
      .signInWithEmail(email: email, password: password)
      .then((value) {
        // get result from facebook login
        if (value == null) {
          onSuccess.call("");
        } else {
          onError.call(value.toString());
        }
      })
      .onError((error, stackTrace) {
        onError.call(error.toString());
      })
      .whenComplete(() => {})
      .catchError((error) {
        onError.call(error.toString());
      });
}

signupWithEmail({
  required BuildContext context,
  required String email,
  required String password,
  required String fullname,
  required Function(String value) onSuccess,
  required Function(String value) onError,
}) {
  DatabaseStore databaseStore = DatabaseStore();
  databaseStore.firebaseInit();

  FirebaseAuthHelper()
      .signUpWithEmail(email: email, password: password)
      .then((value) {
        // get result from facebook login
        if (value == null) {
          String facebookId = "";
          String profilePic = "";
          String loginType = "";

          loginType = "email";

          DatabaseStore().addUserToFireStore(
              fullname, email, loginType, facebookId, profilePic, "", "");
          onSuccess.call("");
        } else {
          onError.call(value.toString());
        }
      })
      .onError((error, stackTrace) {
        onError.call(error.toString());
      })
      .whenComplete(() => {})
      .catchError((error) {
        onError.call(error.toString());
      });
}

loginWithGoogle({
  required BuildContext context,
  required Function(UserCredential value) onSuccess,
  required Function(String value) onError,
}) {
  try {
    FirebaseAuthHelper()
        .signInWithGoogle()
        .then((value) {
          if (value != null) {
            String name = "";
            String email = "";
            String facebookId = "";
            String profilePic = "";
            String loginType = "google";
            final Map<String, dynamic>? profile =
                value.additionalUserInfo!.profile;
            if (profile != null) {
              profile.entries.forEach((element) async {
                String paramkey = element.key.toString();
                String paramvalue = element.value.toString();

                if (paramkey == "picture") {
                  profilePic = paramvalue;
                }
                if (paramkey == "email") {
                  email = paramvalue;
                }
                if (element.key.toString() == "name") {
                  name = paramvalue;
                }
              });

              loginType = "google";
              saveUserData(
                  name: name,
                  email: email,
                  profileurl: profilePic,
                  facebookid: facebookId,
                  isuserlogged: true,
                  logintype: loginType);

              DatabaseStore().addUserToFireStore(
                  name, email, loginType, facebookId, profilePic, "", "");

              Constant.initUserData();
              onSuccess.call(value);
            }
          } else {
            onError.call(value.toString());
          }
        })
        .onError((error, stackTrace) {
          onError.call(error.toString());
        })
        .whenComplete(() => {})
        .catchError((error) {
          onError.call(error.toString());
        });
  } on Exception catch (e) {
    onError.call(e.toString());
  }
}

loginwithFacebook(
    {required BuildContext context,
    required Function(UserCredential value) onSuccess,
    required Function(String value) onError}) {
  DatabaseStore databaseStore = DatabaseStore();
  databaseStore.firebaseInit();

  FirebaseAuthHelper()
      .signInWithFacebook()
      .then((value) {
        // get result from facebook login
        if (value != null) {
          String name = "";
          String email = "";
          String facebookId = "";
          String profilePic = "";
          String loginType = "";
          final Map<String, dynamic>? profile =
              value.additionalUserInfo!.profile;
          profile!.entries.forEach((element) {
            String key = element.key.toString();
            String value = element.value.toString();
// store picture url into local pref.
            if (key == "picture") {
              Map map = element.value;
              profilePic = map["data"]["url"];
            }
            // store name url into local pref.
            if (key == "name") {
              name = value;
            }
            if (key == "id") {
              facebookId = value;
            }
          });
          loginType = "facebook";

          saveUserData(
              name: name,
              email: email,
              profileurl: profilePic,
              facebookid: facebookId,
              isuserlogged: true,
              logintype: loginType);

          DatabaseStore().addUserToFireStore(
              name, "", loginType, facebookId, profilePic, "", "");

          Constant.initUserData();

          onSuccess.call(value);
        } else {
          onError.call(value.toString());
        }
      })
      .onError((error, stackTrace) {
        onError.call(error.toString());
      })
      .whenComplete(() => {})
      .catchError((error) {
        onError.call(error.toString());
      });
}

loginwithTwitter({
  required BuildContext context,
  required Function(UserCredential value) onSuccess,
  required Function(String value) onError,
}) {
  DatabaseStore databaseStore = DatabaseStore();
  databaseStore.firebaseInit();

  FirebaseAuthHelper()
      .signInWithTwitter()
      .then((value) {
        // get result from facebook login
        if (value != null) {
          String name = "";
          String email = "";
          String twitterId = "";
          String profilePic = "";
          String loginType = "twitter";
          final Map<String, dynamic>? profile =
              value.additionalUserInfo!.profile;
          profile!.entries.forEach((element) {
            String key = element.key.toString();
            String value = element.value.toString();
            // print("$key - $value");

            if (key == "name") {
              name = value;
            } else if (key == "email") {
              email = value;
            } else if (key == "profile_image_url_https") {
              profilePic = value;
            } else if (key == "id") {
              twitterId = value;
            }
          });

          saveUserData(
              name: name,
              email: email,
              profileurl: profilePic,
              facebookid: "",
              isuserlogged: true,
              logintype: loginType);

          DatabaseStore().addUserToFireStore(
              name, email, loginType, "", profilePic, twitterId, "");

          Constant.initUserData();

          onSuccess.call(value);
        } else {
          onError.call(value.toString());
        }
      })
      .onError((error, stackTrace) {
        onError.call(error.toString());
      })
      .whenComplete(() => {})
      .catchError((error) {
        onError.call(error.toString());
      });
}

loginwithApple({
  required BuildContext context,
  required Function(UserCredential value) onSuccess,
  required Function(String value) onError,
}) {
  DatabaseStore databaseStore = DatabaseStore();
  databaseStore.firebaseInit();

  FirebaseAuthHelper()
      .signInWithApple()
      .then((value) {
        // get result from facebook login
        if (value != null) {
          String name = "";
          String email = "";
          String twitterId = "";
          String profilePic = "";
          String loginType = "apple";
          final Map<String, dynamic>? profile =
              value.additionalUserInfo!.profile;
          profile!.entries.forEach((element) {
            String key = element.key.toString();
            String value = element.value.toString();
            // print("$key - $value");
            if (key == "email") {
              email = value;
            }
          });

          saveUserData(
              name: Constant.fullname,
              email: email,
              profileurl: profilePic,
              facebookid: "",
              isuserlogged: true,
              logintype: loginType);

          if (!Constant.fullname.contains("null")) {
            DatabaseStore().addUserToFireStore(Constant.fullname, email,
                loginType, "", profilePic, "", Constant.appleToken);
          }

          Constant.initUserData();

          onSuccess.call(value);
        } else {
          onError.call(value.toString());
        }
      })
      .onError((error, stackTrace) {
        onError.call(error.toString());
      })
      .whenComplete(() => {})
      .catchError((error) {
        onError.call(error.toString());
      });
}
