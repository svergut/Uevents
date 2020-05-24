import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:uevents/domain/user.dart';
import 'package:uevents/services/auth.dart';
import 'package:uevents/common/toast.dart';
class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String _email;
  String _password;
  String _confirmPassword;
  String _name;
  bool showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _button(String text, void func()) {
      return RaisedButton(
        splashColor: Colors.white24,
        highlightColor: Colors.white24,
        color: Colors.blue,
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
        onPressed: () {
          func();
        },
      );
    }

    Widget _logo() {
      return Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
              child: Align(
                  child:
                      Image.network('https://i.ibb.co/L1rZpd9/UFU-LOGO.jpg'))));
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1)),
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.grey),
                    child: icon,
                  ))),
        ),
      );
    }

    Widget _form(String label, void func()) {
      return Container(
          child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: _input(Icon(Icons.email), 'Логин', _emailController, false),
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 20),
            child:
                _input(Icon(Icons.lock), 'Пароль', _passwordController, true)),
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func)))
      ]));
    }

    Widget _registerForm(String label, void func()) {
      return Container(
          child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: _input(Icon(Icons.email), 'Имя', _nameController, false),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: _input(Icon(Icons.email), 'Логин', _emailController, false),
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 10),
            child:
                _input(Icon(Icons.lock), 'Пароль', _passwordController, true)),
        Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: _input(Icon(Icons.lock), 'Подтверждение пароля',
                _confirmPasswordController, true)),
                
        SizedBox(
          height: 20,
        ),
        Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func)))
      ]));
    }
  

    void _loginButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;
      _name = _nameController.text;

      if (_email.isEmpty || _password.isEmpty) return;

      User user = await _authService.signInWithEmailAndPasswor(
          _email.trim(), _password.trim());
      if (user == null) {
        buildToast("Не возможно войти, пожалуйста, проверьте логин/пароль");
      } else {
        _emailController.clear();
        _passwordController.clear();
        user.name = _name;
      }
    }

    void _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;
      _confirmPassword = _confirmPasswordController.text;


      if (_email.isEmpty || _password.isEmpty) return;
      User user = await _authService.registerWithEmailAndPassword(
          _email.trim(), _password.trim());
      if (user == null) {
        buildToast("Не возможно зарегистрироваться, пожалуйста, проверьте логин/пароль");
      if (_password != _confirmPassword) {
       buildToast("Пароли не совпадают");
      }
      } else {
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();

      }
    }

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
            )),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            _logo(),
            (showLogin
                ? Column(
                    children: <Widget>[
                      _form('ВОЙТИ', _loginButtonAction),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                            child: Text('Не зарегистрированы?',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey)),
                            onTap: () {
                              setState(() {
                                showLogin = false;
                              });
                            }),
                      )
                    ],
                  )
                : Column(
                    children: <Widget>[
                      _registerForm('Регистрация', _registerButtonAction),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                            child: Text('Ввести логин и пароль',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey)),
                            onTap: () {
                              setState(() {
                                showLogin = true;
                              });
                            }),
                      )
                    ],
                  ))
          ],
        ));
  }
}
