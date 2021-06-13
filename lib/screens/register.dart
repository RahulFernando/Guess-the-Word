import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/screens/home.dart';
import 'package:guess_app/utils/color.dart';
import 'package:guess_app/widgets/header_container.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await _auth.currentUser.updateProfile(displayName: _name);
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
            HeaderContainer("Register"),
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
                            if (input.isEmpty) return 'Enter Name';
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person)),
                          onSaved: (input) => _name = input,
                        ),
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
                        onPressed: signUp,
                        child: Text(
                          'SIGNUP',
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
