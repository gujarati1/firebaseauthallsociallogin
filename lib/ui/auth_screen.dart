import 'package:firebase_auth_all_social/constant/enum.dart';
import 'package:firebase_auth_all_social/model/social_login_model.dart';
import 'package:firebase_auth_all_social/routes/routes.dart';
import 'package:firebase_auth_all_social/setup/firebase_auth_helper.dart';
import 'package:firebase_auth_all_social/ui/common/widgets/button_widget.dart';
import 'package:firebase_auth_all_social/ui/dashboard/dashboard_screen.dart';
import 'package:firebase_auth_all_social/ui/login/login_screen.dart';
import 'package:firebase_auth_all_social/ui/login/mobile_login_screen.dart';
import 'package:firebase_auth_all_social/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var typesOfLoginlist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SocialLoginModel.addLoginTypeList();
    typesOfLoginlist = SocialLoginModel.gettypesOfLoginList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                "Login with : ".text.bold.xl2.make().p16(),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    LoginTypeItem loginTypeItem = typesOfLoginlist[index];
                    return elevatButtonWidget(
                            buttonColor: loginTypeItem.color,
                            context: context,
                            callback: () {
                              if (loginTypeItem.loginType ==
                                  LoginTypeEnum.email) {
                                Utils.redirectToScreen(
                                    context,
                                    LoginScreen(
                                     
                                    ));
                              } else if (loginTypeItem.loginType ==
                                  LoginTypeEnum.mobile) {
                                    Utils.redirectToScreen(
                                    context,
                                    MobileLoginScreen(
                                     loginTypeEnum: LoginTypeEnum.mobile, 
                                    ));
                              } else if (loginTypeItem.loginType ==
                                  LoginTypeEnum.google) {
                                callLoginWithGoogle();
                              } else if (loginTypeItem.loginType ==
                                  LoginTypeEnum.facebook) {
                                callLoginWithFacebook();
                              } else if (loginTypeItem.loginType ==
                                  LoginTypeEnum.twitter) {
                                callLoginWithTwitter();
                              } else if (loginTypeItem.loginType ==
                                  LoginTypeEnum.apple) {
                                callLoginWithApple();
                              } else if (loginTypeItem.loginType ==
                                  LoginTypeEnum.github) {
                              } else if (loginTypeItem.loginType ==
                                  LoginTypeEnum.microsoft) {
                              } else if (loginTypeItem.loginType ==
                                  LoginTypeEnum.yahoo) {}
                            },
                            buttonTitle: loginTypeItem.title)
                        .p16();
                  },
                  itemCount: typesOfLoginlist.length,
                ).expand(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void callLoginWithGoogle() {
    loginWithGoogle(
      context: context,
      onSuccess: (value) {
        print("object");
        Utils.redirectToScreen(context, const DashboardScreen());
      },
      onError: (value) {
        print("object");
      },
    );
  }

  void callLoginWithFacebook() {
    loginwithFacebook(
      context: context,
      onSuccess: (value) {
        print("object");
        Utils.redirectToScreen(context, const DashboardScreen());
      },
      onError: (value) {
        print("object");
      },
    );
  }

  void callLoginWithTwitter() {
    loginwithTwitter(
      context: context,
      onSuccess: (value) {
        print("object");
        Utils.redirectToScreen(context, const DashboardScreen());
      },
      onError: (value) {
        print("object");
      },
    );
  }

  void callLoginWithApple() {
    loginwithApple(
      context: context,
      onSuccess: (value) {
        print("object");
        Utils.redirectToScreen(context, const DashboardScreen());
      },
      onError: (value) {
        print("object");
      },
    );
  }
}
