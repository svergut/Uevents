import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EventCard {
  static Widget createCard(BuildContext context) 
  {

    return Column(children: <Widget>[
      Container( 
      padding: EdgeInsets.only(top: 38),
      width: 386,
      height: 278,
      decoration: BoxDecoration( 
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(225, 225, 225, 1),
        boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 10, offset: Offset(0, 4))]
      ),
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: Color.fromRGBO(240, 240, 240, 1), borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
         children: <Widget>[
           Text('Header'),
           Text('Description')
         ], 
        ),
      )
      )
    ]);
  }
}