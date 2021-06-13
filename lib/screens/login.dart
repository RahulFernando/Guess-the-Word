import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/screens/home.dart';
import 'package:guess_app/utils/color.dart';
import 'package:guess_app/widgets/header_container.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });

    @override
    Void initState() {
      super.initState();
      this.checkAuthentification();
    }
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
        try {
            UserCredential user = await _auth.signInWithEmailAndPassword(
                email: _email, password: _password);
                if (user.user.email == 'admin@gmail.com'){
                  Navigator.pushReplacementNamed(context, 'adminWelcome');
                }else {
                   Navigator.pushReplacementNamed(context, 'home');
                }
        } catch (e) {
            showError(e.message);
        }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Login"),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.length < 6)
                              return 'Provide Minimum 6 Character Password';
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock)),
                          obscureText: true,
                          onSaved: (input) => _password = input,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: purpleColors, // background
                          onPrimary: Colors.white,
                          padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(100.0)), // foreground
                        ),
                        onPressed: login,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
