import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth_all_social/constant/constant.dart';
import 'package:firebase_auth_all_social/provider/firebase_auth_provider.dart';
import 'package:firebase_auth_all_social/ui/auth_screen.dart';
import 'package:firebase_auth_all_social/ui/common/widgets/button_widget.dart';
import 'package:firebase_auth_all_social/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: "Dashboard".text.make(),
        ),
        bottomNavigationBar: elevatButtonWidget(
                context: context,
                callback: () {
                  Utils.clearPrefLoginData();
                  Utils.redirectToNextScreen(context, const AuthScreen());
                },
                buttonTitle: "Logout",
                buttonColor: Colors.blue)
            .p24(),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(Provider.of<FirebaseAuthNotifierProvider>(context, listen: true).profileImageUrl).wh(100, 100),
              const SizedBox(
                height: 10,
              ),
              Provider.of<FirebaseAuthNotifierProvider>(context, listen: true).fullname.text.xl3.make().centered(),
              const SizedBox(
                height: 10,
              ),
              Provider.of<FirebaseAuthNotifierProvider>(context, listen: true).emailPref.text.make().centered(),
            ],
          ),
        ),
      ),
    );
  }
}
