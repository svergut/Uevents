import 'package:firebase_auth/firebase_auth.dart';

class User{
  String id;
  String name;

  User.fromFirebase(FirebaseUser user){
    id = user.uid;
    name = user.displayName;
  }
}