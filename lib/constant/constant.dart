import 'package:firebase_auth_all_social/provider/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth_all_social/pref/shared_pref.dart';
import 'package:velocity_x/velocity_x.dart';

class Constant {
  //
  static String fontfamilySourcePro = "SourceSansPro";
  static String loginType = "login_type";
  static String userProfileUrl = "profile_url";
  static String email = "email";
  static String name = "name";
  static String facebookID = "faceboook_id";
  static String isUserLoggedInStr = "loggedin";

// Firebase constant string
  static String tbluser = "users";
  static String tblTaskList = "task_list";
  static String tblArchiveTaskList = "archive_list";
  static String tblDeletedTaskList = "deleted_list";
  static String collectionToDo = "ToDo";
  static String collectionUserDetail = "user_detail";
  static String collectionArchiveList = "archive_list";

// Task string
  static String taskid = "task_id";
  static String tasktitle = "task_title";
  static String taskdesc = "task_desc";
  static String createdTimestamp = "created_timestamp";
  static String updatedTimestamp = "updated_timestamp";
  static String timestamp = "timestamp";
  static String priority = "priority";
  static String iscomplete = "is_complete";
  static String isbookmark = "is_bookmark";
  static String taskSelectDate = "date";
  static String userid = "user_id";
  static String date = "date";

  static void showSnackBar(BuildContext context, actionType, String message) {
    Color textColor = Colors.white;
    Color? bgColor = Colors.black;
    if (actionType.isNotEmpty) {
      if (actionType == TaskActionTypeEnum.add) {
        textColor = Colors.white;
        bgColor = Colors.green;
      } else if (actionType == TaskActionTypeEnum.update) {
        textColor = Colors.white;
        bgColor = Colors.yellow[800];
      } else if (actionType == TaskActionTypeEnum.complete) {
        textColor = Colors.white;
        bgColor = Colors.green;
      } else if (actionType == TaskActionTypeEnum.incomplete) {
        textColor = Colors.white;
        bgColor = Colors.red;
      } else if (actionType == TaskActionTypeEnum.delete) {
        textColor = Colors.white;
        bgColor = Colors.red;
      }
    }
    VxToast.show(context,
        msg: message, bgColor: bgColor, textColor: textColor, textSize: 15);
  }

  static DateTime dateTime = DateTime.now();
  static DateFormat dateFormat = DateFormat("EEE, d MMM");

  static String profileImageUrl = "";
  static String fullname = "";
  static String emailPref = "";
static String appleToken = "";

  static void initUserData() {
    // getPrefStirngData(Constant.userProfileUrl).then((value) {
    //   if (value != null && value.isNotEmpty) {
    //     profileImageUrl = value;
    //   } else {
    //     profileImageUrl =
    //         "https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png";
    //   }
    // });
    // getPrefStirngData(Constant.name).then((value) {
    //   fullname = value!;
    // });
    // getPrefStirngData(Constant.email).then((value) {
    //   emailPref = value!;
    // });
    FirebaseAuthNotifierProvider();
  }
}

void saveUserData(
    {required String name,
    required String email,
    required String logintype,
    required String facebookid,
    required String profileurl,
    required bool isuserlogged}) {
  savePrefStringData(Constant.name, name);
  savePrefStringData(Constant.email, email);
  savePrefStringData(Constant.loginType, logintype);
  savePrefStringData(Constant.facebookID, facebookid);
  savePrefStringData(Constant.userProfileUrl, profileurl);
  savePrefBoolData(Constant.isUserLoggedInStr, isuserlogged);
}

class TaskActionTypeEnum {
  static String add = 'add';
  static String update = 'update';
  static String delete = 'delete';
  static String complete = 'complete';
  static String incomplete = 'incomplete';
}

class PriorityEnum {
  static String high = 'High';
  static String medium = 'Medium';
  static String low = 'Low';
  static String verylow = 'Very Low';
}

class TaskTypeEnum {
  static String all = 'All';
  static String complete = 'Complete';
  static String incomplete = 'Incomplete';
  static String favourite = 'favourite';
  static String archive = 'archive';
}
