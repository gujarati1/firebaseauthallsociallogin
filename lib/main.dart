import 'package:firebase_auth_all_social/provider/firebase_auth_provider.dart';
import 'package:firebase_auth_all_social/routes/routes.dart';
import 'package:firebase_auth_all_social/setup/firebase/firebase_setup.dart';
import 'package:firebase_auth_all_social/ui/auth_screen.dart';
import 'package:firebase_auth_all_social/ui/login/login_screen.dart';
import 'package:firebase_auth_all_social/ui/signup/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => FirebaseAuthNotifierProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(),
      routes: {
        MyRoutes.homeScreen: (context) => const AuthScreen(),
        MyRoutes.loginScreen: (context) => LoginScreen(),
        MyRoutes.signupScreen: (context) => SignupScreen(),
      },
    );
  }
}
