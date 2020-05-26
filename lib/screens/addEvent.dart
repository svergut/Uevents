import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:uevents/common/savebutton.dart';
import 'package:uevents/common/toast.dart';
import 'package:uevents/data/data.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/database.dart';

class AddEvent extends StatefulWidget {
  AddEvent({Key key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _fbKey = GlobalKey<FormBuilderState>();
  User user;

  Data event = Data(
    'id',
    'a',
    'a',
    'a',
    'a',
    'a',
  );

  @override
  void initState() {
    super.initState();
  }

  void _saveEvent() async {
    if (_fbKey.currentState.saveAndValidate()) {
      if (event == null) {
        buildToast('Пожалуйста, проверьте ивент');
        return;
      }
      DateTime now = DateTime.now();

      if(event.uid == 'id'){
        event.uid = user.id + now.toString();
      }
      await DatabaseService().addOrUpdateEvent(event);
      Navigator.of(context).pop();
    } else {
      buildToast('Упс! Что-то пошло не так');
    }
  }

  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title:
                  Text('Создание мероприятия', style: TextStyle(fontSize: 20)),
              backgroundColor: Colors.pinkAccent,
              actions: <Widget>[SaveButton(onPressed: _saveEvent)],
            ),
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white),
              child: ListView(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    autovalidate: false,
                    initialValue: {},
                    readOnly: false,
                    child: Column(children: <Widget>[
                      FormBuilderTextField(
                        attribute: "название",
                        decoration: InputDecoration(
                          labelText: "Название*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.title = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(100),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "краткое описание",
                        decoration: InputDecoration(
                          labelText: "Краткое описание*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.shortDescription = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(200),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "полное описание",
                        decoration: InputDecoration(
                          labelText: "Полное описание*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.description = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(1500),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "организатор",
                        decoration: InputDecoration(
                          labelText: "Организатор*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.organizer = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(100),
                        ],
                      ),
                      FormBuilderTextField(
                        attribute: "адрес",
                        decoration: InputDecoration(
                          labelText: "Адрес*",
                        ),
                        onChanged: (dynamic val) {
                          setState(() {
                            event.adress = val;
                          });
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(100),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            )));
  }
}
