import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String text;
  final int index;
  final VoidCallback press;

  const Option({Key key, this.text, this.index, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(top: 12, right: 5, left: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${index + 1}. $text",
            style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

