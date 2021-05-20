import 'package:flutter/material.dart';
import 'package:guess_app/widgets/option.dart';

class QuizBody extends StatelessWidget {
  const QuizBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.help,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('1/20')
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        'Not limited or restricted in terms of number, quantity or extend',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Option(),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Check',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.purple,
              )
            ],
          ),
        )),
      ],
    );
  }
}
