import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/utils/color.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user ==null) {
        Navigator.pushReplacementNamed(context, "welcome");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser !=null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: !isloggedin
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 400.0),
                    child: Text(
                      "Hello ${user.displayName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: purpleColors),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: purpleColors, // background
                      onPrimary: Colors.white,
                      padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(100.0)), // foreground
                    ),
                    onPressed: signOut,
                    child: Text(
                      'SIGNOUT',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
