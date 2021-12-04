import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_all_social/constant/constant.dart';
import 'package:firebase_auth_all_social/setup/firebase/firebase_setup.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FirebaseAuthNotifierProvider extends ChangeNotifier {
  FirebaseAuthNotifierProvider() {
    init();
  }
  User? user;
  Future<void> init() async {
    await FirebaseSetup().firebaseInit();

    if (!kIsWeb) {
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null) {
        user = event;

        usersSubscription = FirebaseFirestore.instance
            .collection(Constant.tbluser)
            .where(Constant.userid,
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots()
            .listen((value) {
          QuerySnapshot<Map<String, dynamic>> snapshot = value;

          value.docs.forEach((element) {
            Map<String, dynamic> data = element.data();

            if (element.data()[Constant.userid] ==
                FirebaseAuth.instance.currentUser!.uid) {
              fullname = element.data()[Constant.name];
              emailPref = element.data()[Constant.email];
              profileImageUrl = element.data()[Constant.userProfileUrl];
              profileImageUrl = !profileImageUrl.isEmpty
                  ? profileImageUrl
                  : "https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png";
              saveUserData(
                  name: element.data()[Constant.name],
                  email: element.data()[Constant.email],
                  logintype: element.data()[Constant.loginType],
                  isuserlogged: true,
                  facebookid: element.data()["fb_id"],
                  profileurl: element.data()[Constant.userProfileUrl]);
              // Constant.initUserData();
            }
          });
          notifyListeners();
        });
      }
    });
  }

  String profileImageUrl = "";
  String fullname = "";
  String emailPref = "";

  StreamSubscription<QuerySnapshot>? usersSubscription;
  @override
  void dispose() {
    super.dispose();
    usersSubscription!.cancel();
  }
}
