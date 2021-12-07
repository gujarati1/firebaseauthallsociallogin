// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_all_social/constant/enum.dart';
import 'package:firebase_auth_all_social/setup/firebase_auth_helper.dart';
import 'package:firebase_auth_all_social/ui/login/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth_all_social/constant/strings.dart';
import 'package:firebase_auth_all_social/ui/common/input_field.dart';
import 'package:firebase_auth_all_social/ui/common/widgets/button_widget.dart';
import 'package:firebase_auth_all_social/ui/signup/signup_screen.dart';
import 'package:firebase_auth_all_social/ui/utils/utils.dart';

class MobileLoginScreen extends StatefulWidget {
  LoginTypeEnum? loginTypeEnum;
  MobileLoginScreen({
    Key? key,
    this.loginTypeEnum,
  }) : super(key: key);

  @override
  _MobileLoginScreenState createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var mobileNumberController = TextEditingController();
  bool spinnerVisible = false;
  bool isExpand = true;
  String _verificationId = "";
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

                    mobileNumberFormWidget(),

                    //  sign in button
                    elevatButtonWidget(
                            buttonColor: Theme.of(context).primaryColor,
                            context: context,
                            callback: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                _verifyPhoneNumber();
                              }
                            },
                            buttonTitle: Strings.signin)
                        .p20(),
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

  Widget mobileNumberFormWidget() {
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
                  controller: mobileNumberController,
                  hintText: Strings.mobilenumber,
                  labelText: Strings.mobilenumber,
                  errorText: Strings.entermobilenumber,
                  emailValidation: false,
                  isPassword: false,
                  isShowPwdToggleText: false,
                  keyboardType: TextInputType.number,
                  mobileValidation: true,
                  maxLength: 10,
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyPhoneNumber() async {
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      // Utility.showToast(msg: authException.message);
      print(authException.code);
      print(authException.message);
      
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("codeAutoRetrievalTimeout");
      _verificationId = verificationId;
    };

    // ignore: prefer_function_declarations_over_variables
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      print("verificationCompleted");
    };

    await FirebaseAuth.instance
        .verifyPhoneNumber(
            phoneNumber: "+91${mobileNumberController.text}",
            timeout: const Duration(seconds: 5),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: (verificationId, forceResendingToken) {
              _verificationId = verificationId;
              Utils.redirectToScreen(
                  context, OtpScreen(verificationId: verificationId));
            },
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      print("then");
    }).catchError((onError) {
      print(onError);
    });
  }
}
