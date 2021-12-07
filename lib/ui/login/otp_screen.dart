// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_all_social/ui/dashboard/dashboard_screen.dart';
import 'package:firebase_auth_all_social/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:firebase_auth_all_social/constant/strings.dart';
import 'package:firebase_auth_all_social/ui/common/input_field.dart';
import 'package:firebase_auth_all_social/ui/common/widgets/button_widget.dart';

class OtpScreen extends StatefulWidget {
  String verificationId;
  OtpScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var otpController = TextEditingController();
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
          title: "OTP".text.make(),
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
                    "Verify OTP"
                        .text
                        .xl3
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
                                _signInWithPhoneNumber(otpController.text);
                              }
                            },
                            buttonTitle: "Submit OTP")
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
                  controller: otpController,
                  hintText: Strings.otp,
                  labelText: Strings.otp,
                  errorText: Strings.enterotp,
                  emailValidation: false,
                  isPassword: false,
                  isShowPwdToggleText: false,
                  keyboardType: TextInputType.number,
                  mobileValidation: false,
                  maxLength: 6,
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

  void _signInWithPhoneNumber(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );
      final User? user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      final User? currentUser = FirebaseAuth.instance.currentUser;
      assert(user!.uid == currentUser!.uid);

      if (user != null) {
        Utils.redirectToScreen(context, const DashboardScreen());
      } else {}
    } catch (e) {
      print(e);
    }
  }
}
