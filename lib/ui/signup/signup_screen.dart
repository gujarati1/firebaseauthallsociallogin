import 'package:firebase_auth_all_social/constant/constant.dart';
import 'package:firebase_auth_all_social/constant/enum.dart';
import 'package:firebase_auth_all_social/constant/strings.dart';
import 'package:firebase_auth_all_social/setup/firebase_auth_helper.dart';
import 'package:firebase_auth_all_social/ui/common/input_field.dart';
import 'package:firebase_auth_all_social/ui/common/widgets/button_widget.dart';
import 'package:firebase_auth_all_social/ui/login/login_screen.dart';
import 'package:firebase_auth_all_social/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool obscurePwdext = true;
  bool obscureTextConfirmpPwd = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: "Sign up".text.make(),
        ),
        key: scaffoldKey,
        body: Container(
          child: Stack(
            children: [
              SafeArea(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Strings.createnewaccount.text.xl3
                            .textStyle(const TextStyle(
                              fontFamily: Strings.robotoBold,
                              fontWeight: FontWeight.w700,
                            ))
                            .make(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
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
                                    InputFieldWidget(
                                      parentContext: context,
                                      controller: usernameController,
                                      hintText: Strings.username,
                                      labelText: Strings.username,
                                      errorText: Strings.errentervalidemail,
                                      emailValidation: true,
                                      isPassword: false,
                                      keyboardType: TextInputType.emailAddress,
                                      mobileValidation: false,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InputFieldWidget(
                                      parentContext: context,
                                      controller: firstNameController,
                                      hintText: Strings.firstname,
                                      labelText: Strings.firstname,
                                      errorText: Strings.errenterrestaurantname,
                                      emailValidation: false,
                                      isPassword: true,
                                      keyboardType: TextInputType.text,
                                      mobileValidation: false,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InputFieldWidget(
                                      parentContext: context,
                                      controller: lastNameController,
                                      hintText: Strings.lastname,
                                      labelText: Strings.lastname,
                                      errorText:
                                          Strings.errenterrestaurantusername,
                                      emailValidation: false,
                                      isPassword: true,
                                      keyboardType: TextInputType.text,
                                      mobileValidation: false,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Strings.usernameshopuldbe.text.sm
                                        .make()
                                        .centered(),
                                    const SizedBox(
                                      height: 10,
                                    ),
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
                                      keyboardType: TextInputType.text,mobileValidation: false,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InputFieldWidget(
                                      parentContext: context,
                                      controller: confirmPasswordController,
                                      hintText: Strings.confirmpassword,
                                      labelText: Strings.confirmpassword,
                                      errorText:
                                          Strings.errenterconfirmpassword,
                                      emailValidation: false,
                                      isPassword: true,
                                      isShowPwdToggleText: true,
                                      pwdObsureText: true,
                                      keyboardType: TextInputType.text,
                                      mobileValidation: false,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Signup button widget
                        elevatButtonWidget(
                                context: context,
                                callback: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    firebaseEmailSignup();
                                  }
                                },
                                buttonTitle: Strings.signup,
                                buttonColor: Colors.blue)
                            .p20(),
                        didnthaveAccountWidget(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget didnthaveAccountWidget() {
    return InkWell(
      onTap: () {
        Utils.redirectToNextScreen(context, LoginScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Strings.alreadyhaveaccount.text
              .textStyle(const TextStyle(
                fontFamily: Strings.robotoRegular,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ))
              .make(),
          const SizedBox(
            width: 5,
          ),
          Strings.signin.text
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

  void firebaseEmailSignup() {
    signupWithEmail(
      context: context,
      email: usernameController.text.toString(),
      password: passwordController.text.toString(),
      fullname: "${firstNameController.text} ${lastNameController.text}",
      onSuccess: (value) {
        Utils.redirectToNextScreen(context, LoginScreen());
      },
      onError: (value) {},
    );
  }
}
