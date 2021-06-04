import 'package:flutter/material.dart';
import 'package:guess_app/screens/login.dart';
import 'package:guess_app/screens/register.dart';
import 'package:guess_app/utils/color.dart';
import 'package:guess_app/widgets/btn_widget.dart';
import 'package:guess_app/widgets/header_container.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer(''),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Welcome To ',
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: purpleColors),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Guess The Word',
                            style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: purpleColors),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text('Refresh your knowledge about the words',
                    style: TextStyle(fontSize: 20.0, color: purpleLightColors),
                    ),
                    SizedBox(height: 100.0,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 35.0,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: purpleColors, // background
                            onPrimary: Colors.white,
                            fixedSize:  Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0) 
                            ),// foreground
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                              'LOGIN',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 30.0,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: purpleColors, // background
                            onPrimary: Colors.white,
                            fixedSize: Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0) 
                            ),// foreground
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                              'REGISTER',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
