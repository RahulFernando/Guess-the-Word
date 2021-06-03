import 'package:flutter/material.dart';
import 'package:guess_app/utils/color.dart';

class ButtonWidget extends StatelessWidget {
  var btnText ="";
  var onClick;


  ButtonWidget({this.btnText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [purpleColors, purpleLightColors],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
