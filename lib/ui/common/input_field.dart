import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:firebase_auth_all_social/constant/strings.dart';
import 'package:firebase_auth_all_social/ui/utils/utils.dart';

class InputFieldWidget extends StatefulWidget {
  BuildContext parentContext;
  TextEditingController? controller;
  String? hintText;
  String? labelText;
  String? errorText;
  bool isPassword = false;
  bool emailValidation = false;
  bool isShowPwdToggleText;
  bool pwdObsureText;
  bool mobileValidation = false;
  TextInputType keyboardType;
  int maxLength = 0;
  InputFieldWidget({
    Key? key,
    required this.parentContext,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    required this.isPassword,
    required this.emailValidation,
    this.isShowPwdToggleText = false,
    this.pwdObsureText = false,
    this.mobileValidation = false,
    required this.keyboardType,
    this.maxLength = 100,
  }) : super(key: key);

  @override
  _InputFieldWidgetState createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? widget.pwdObsureText : widget.isPassword,
      controller: widget.controller,
      style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: Strings.robotoRegular),
      validator: (value) {
        bool emailValid = emailValidation(value!);
        if (value.toString().isEmpty) {
          return widget.errorText;
        } else if (widget.emailValidation && !emailValid) {
          return "Please enter valid email";
        } else if (widget.mobileValidation &&
            widget.controller!.text.length != 10) {
          return "Please enter 10 digit mobile number";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        filled: false,
        disabledBorder: InputBorder.none,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Theme.of(widget.parentContext).textTheme.bodyText1!.color,
        ),
        border: const UnderlineInputBorder(borderSide: BorderSide()),
        suffixIcon: widget.isShowPwdToggleText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.pwdObsureText = !widget.pwdObsureText;
                  });
                },
                child: Icon(
                  widget.pwdObsureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              )
            : Container().wh(0, 0),
      ),
    );
  }
}
