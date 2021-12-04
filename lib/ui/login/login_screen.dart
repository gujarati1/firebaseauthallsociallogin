import 'package:firebase_auth_all_social/constant/constant.dart';
import 'package:firebase_auth_all_social/constant/strings.dart';
import 'package:firebase_auth_all_social/provider/firebase_auth_provider.dart';
import 'package:firebase_auth_all_social/setup/firebase_auth_helper.dart';
import 'package:firebase_auth_all_social/ui/common/input_field.dart';
import 'package:firebase_auth_all_social/ui/common/widgets/button_widget.dart';
import 'package:firebase_auth_all_social/ui/dashboard/dashboard_screen.dart';
import 'package:firebase_auth_all_social/ui/signup/signup_screen.dart';
import 'package:firebase_auth_all_social/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool spinnerVisible = false;
  bool isExpand = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: "Sign in".text.make(),
        ),
        key: scaffoldKey,
        body: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Strings.signintoaccount.text.xl3
                        .textStyle(const TextStyle(
                          fontFamily: Strings.robotoBold,
                          fontWeight: FontWeight.w700,
                          // color: AppColors.primaryColor,
                        ))
                        .make(),
                    // Email & password
                    formWidget(),

                    //  sign in button
                    elevatButtonWidget(
                            buttonColor: Theme.of(context).primaryColor,
                            context: context,
                            callback: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                firebaseEmailSignIn();
                              }
                            },
                            buttonTitle: Strings.signin)
                        .p20(),

                    didnthaveAccountWidget(),
                  ],
                ).wh(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 10,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                // Email Widget
                InputFieldWidget(
                  parentContext: context,
                  controller: usernameController,
                  hintText: Strings.username,
                  labelText: Strings.username,
                  errorText: Strings.errentervalidemail,
                  emailValidation: true,
                  isPassword: false,
                  isShowPwdToggleText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Password Widget
                InputFieldWidget(
                  parentContext: context,
                  controller: passwordController,
                  hintText: Strings.password,
                  labelText: Strings.password,
                  errorText: Strings.errenterpassword,
                  emailValidation: false,
                  isPassword: true,
                  isShowPwdToggleText: true,
                  pwdObsureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Strings.forgotpassword.text
                      .textStyle(const TextStyle(
                        fontFamily: Strings.robotoBold,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ))
                      .make(),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget didnthaveAccountWidget() {
    return InkWell(
      onTap: () {
        Utils.redirectToScreen(context, SignupScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Strings.donthaveaccount.text
              .textStyle(const TextStyle(
                fontFamily: Strings.robotoRegular,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ))
              .make(),
          const SizedBox(
            width: 5,
          ),
          Strings.signup.text
              .textStyle(const TextStyle(
                fontFamily: Strings.robotoBold,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ))
              .make(),
        ],
      ),
    );
  }

  void firebaseEmailSignIn() {
    // showLoading();
    loginWithEmail(
      context: context,
      email: usernameController.text.toString(),
      password: passwordController.text.toString(),
      onSuccess: (value) {
        // hideLoading(true, "Successfully Login");
        saveUserData(
            email: usernameController.text,
            logintype: "email",
            isuserlogged: true,
            facebookid: "",
            profileurl: "",
            name: "");
        FirebaseAuthNotifierProvider();
        
        Utils.redirectToNextScreen(context, const DashboardScreen());
      },
      onError: (value) {
        // hideLoading(false, value);
      },
    );
  }
}
