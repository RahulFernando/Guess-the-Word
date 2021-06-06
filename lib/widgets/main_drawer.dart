import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guess_app/utils/color.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    navigateLogin() async {
      Navigator.pushReplacementNamed(context, "login");
    }

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: purpleLightColors,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/img/worker.png'),
                      ),
                    ),
                  ),
                  _auth.currentUser != null
                      ? Text(
                          _auth.currentUser.email,
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontFamily: 'Righteous'),
                        )
                      : Text(''),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: () async {
              await _auth.signOut().then((value) => navigateLogin());
            },
          )
        ],
      ),
    );
  }
}
