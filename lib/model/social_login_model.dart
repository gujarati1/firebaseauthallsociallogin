import 'package:flutter/material.dart';

import 'package:firebase_auth_all_social/constant/enum.dart';

class SocialLoginModel {
  static List<LoginTypeItem> typesOfLoginList = [];
  static List<LoginTypeItem> get gettypesOfLoginList => typesOfLoginList;
 static void addLoginTypeList() {
    typesOfLoginList = [];
    typesOfLoginList.add(LoginTypeItem(
      title: "Email",
      loginType: LoginTypeEnum.email,
      color: Colors.blue,
    ));
    typesOfLoginList.add(LoginTypeItem(
      title: "Mobile",
      loginType: LoginTypeEnum.mobile,
      color: Colors.blue,
    ));
    typesOfLoginList.add(LoginTypeItem(
      title: "Google",
      loginType: LoginTypeEnum.google,
      color: Colors.red[900],
    ));
    typesOfLoginList.add(LoginTypeItem(
      title: "Facebook",
      loginType: LoginTypeEnum.facebook,
      color: Colors.blue[900],
    ));
    typesOfLoginList.add(
      LoginTypeItem(
          title: "Twitter",
          loginType: LoginTypeEnum.twitter,
          color: Colors.blue[800]),
    );
    typesOfLoginList.add(
      LoginTypeItem(
          title: "Apple", loginType: LoginTypeEnum.apple, color: Colors.black),
    );
    typesOfLoginList.add(
      LoginTypeItem(
          title: "Github", loginType: LoginTypeEnum.github, color: Colors.grey),
    );
    typesOfLoginList.add(
      LoginTypeItem(
          title: "Microsoft",
          loginType: LoginTypeEnum.microsoft,
          color: Colors.orange),
    );
    typesOfLoginList.add(
      LoginTypeItem(
          title: "Yahoo", loginType: LoginTypeEnum.yahoo, color: Colors.indigo),
    );
  }
}

class LoginTypeItem {
  LoginTypeEnum loginType;
  String title;
  Color? color;
  LoginTypeItem({
    required this.loginType,
    required this.title,
    required this.color,
  });
}
