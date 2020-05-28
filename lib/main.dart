import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Uevents/screens/landing.dart';
import 'package:Uevents/services/auth.dart';

import 'domain/user.dart';
void main() => runApp(UEvents());

class UEvents extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return StreamProvider<User>.value(
      value: AuthService().currentUser,
          child: MaterialApp(
        title: 'Uevents',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(255, 8, 127, 1),
        ),
        home: LandingPages()
      ),
    );
  }
}


