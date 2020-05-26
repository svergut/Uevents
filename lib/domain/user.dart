import 'package:firebase_auth/firebase_auth.dart';

class User{
  String id;
  String name;

  User.fromFirebase(FirebaseUser fUser){
    id = fUser.uid;
  }
}