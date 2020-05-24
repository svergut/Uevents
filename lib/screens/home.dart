
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uevents/domain/eventCard.dart';
import 'package:uevents/screens/addEvent.dart';
import 'package:uevents/services/auth.dart';

class Landing extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('U.Events', style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.pinkAccent,
        ),
        
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 5),
              child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                        elevation: 15,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.network(
                              "https://urfu.ru/fileadmin/user_upload/common_files/about/brand/UrFULogo_U.png",
                              height: 100,
                              width: 100),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      Text(
                        'user',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  )),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.pinkAccent, Colors.orange])),
            ),
            CustomListTile(Icons.person, 'Профиль', () => {}),
            CustomListTile(Icons.notifications, 'Уведомления', () => {}),
            CustomListTile(Icons.settings, 'Настройки', () {}),
            CustomListTile(Icons.exit_to_app, 'Выйти', () {
              AuthService().logOut();
            }),
          ],
        )),
        body: Container(
            child: EventCard.createCard(context),
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            alignment: Alignment.topCenter),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => AddEvent()));
        },    
      ),
      )
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: InkWell(
                splashColor: Colors.pinkAccent,
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          child: Text(text, style: TextStyle(fontSize: 16)),
                          padding: EdgeInsets.all(8),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ),
              ),
            )));
  }
}

class LandingPage extends StatefulWidget {
  @override
  Landing createState() => Landing();
}
