import 'package:firebase_auth_all_social/constant/constant.dart';
import 'package:firebase_auth_all_social/pref/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Utils {

  static void clearPrefLoginData() {
    savePrefBoolData(Constant.isUserLoggedInStr, false);
    removePrefData(Constant.email);
    removePrefData(Constant.name);
    removePrefData(Constant.userProfileUrl);
  }
  
  static void redirectToNextScreen(BuildContext context, Widget routeWidget) {
    Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
            child: routeWidget, type: PageTransitionType.rightToLeft),
        (route) => false);
  }

  static void redirectToScreen(BuildContext context, Widget routeWidget) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: routeWidget,
      ),
    );
  }
}

 
Widget setSpaceHeight(double height) {
  return SizedBox(
    height: height,
  );
}

bool emailValidation(String s) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(s.toString());
}
