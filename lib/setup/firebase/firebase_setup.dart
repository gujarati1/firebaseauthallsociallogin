import 'package:firebase_core/firebase_core.dart';

class FirebaseSetup {
  Future<FirebaseApp> firebaseInit() async {
    return await Firebase.initializeApp();
  }
}
