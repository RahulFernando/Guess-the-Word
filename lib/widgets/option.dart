import 'package:flutter/material.dart';

class Option extends StatefulWidget {
  const Option({Key key}) : super(key: key);

  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  List<bool> checked = [true, true, false, false, true];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (var i = 0; i < 4; i++)
            Row(
              children: [
                Checkbox(
                  value: checked[i],
                  onChanged: i == 4
                      ? null
                      : (bool value) {
                          setState(() {
                            checked[i] = value;
                          });
                        },
                ),
                Text(
                  'Checkbox ${i+1}'
                )
              ],
            )
        ],
      ),
    );
  }
}
