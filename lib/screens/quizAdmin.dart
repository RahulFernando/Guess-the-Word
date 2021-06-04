
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/question.dart';
import '../controllers/question_controller.dart';



class QuizAdminDemo extends StatefulWidget {
   QuizAdminDemo() : super();

  final String appTitle = "Quiz DB";
  @override
  _QuizAdminDemoState createState() => _QuizAdminDemoState();
}


class _QuizAdminDemoState extends State<QuizAdminDemo> {

final controller = QuestionController();

TextEditingController questionController = TextEditingController();
TextEditingController optionController1 = TextEditingController();
TextEditingController optionController2 = TextEditingController();
TextEditingController optionController3 = TextEditingController();
TextEditingController optionController4 = TextEditingController();

bool option1 = false;
bool option2 = false;
bool option3 = false;
bool option4 = false;


bool isEditing = false;
bool textFieldvisibility = false; 

String firestoreCollectionName = "test";

Question currentQuestion;


addBook(){

    List<String> optionsList = [optionController1.text, optionController2.text, optionController3.text, optionController4.text];
    List<bool> answerList = [option1,option2,option3,option4];

    Question questionObj = Question(question: questionController.text,options: optionsList,answerList: answerList);

    controller.addQuestion(questionObj);

    Fluttertoast.showToast(  
        msg: 'New Question has been added !',  
        toastLength: Toast.LENGTH_SHORT,  
        gravity: ToastGravity.BOTTOM,  
        timeInSecForIos: 1,  
        backgroundColor: Colors.white,  
        textColor: Colors.green  
    );  

}

updateIfEditing(){

    List<String> newOptionsList = [optionController1.text, optionController2.text, optionController3.text, optionController4.text];
    List<bool> newAnswerList = [option1,option2,option3,option4];

    if(isEditing){
       controller.updateQuestion(currentQuestion,questionController.text,newOptionsList,newAnswerList);
      setState(() {
        isEditing = false;
      });
    }

    Fluttertoast.showToast(  
        msg: 'Selected Question has been updated !',  
        toastLength: Toast.LENGTH_SHORT,  
        gravity: ToastGravity.BOTTOM,  
        timeInSecForIos: 1,  
        backgroundColor: Colors.white,  
        textColor: Colors.blue  
    );  
  }

setUpdateUI(Question questionObj){
      viewDialogBox(context);
      questionController.text = questionObj.question;
      optionController1.text = questionObj.options[0];
      optionController2.text = questionObj.options[1];
      optionController3.text = questionObj.options[2];
      optionController4.text = questionObj.options[3];

      option1 = questionObj.answerList[0];
      option2 = questionObj.answerList[1];
      option3 = questionObj.answerList[2];
      option4 = questionObj.answerList[3];

      setState(() {
        textFieldvisibility = true;
        isEditing = true;
        currentQuestion = questionObj;
      });
 }

button(){
      return SizedBox(
        width: double.infinity,
        child: OutlineButton(
          child:Text(isEditing? "UPDATE" : "ADD"),
          onPressed: (){
            if(isEditing == true){
              updateIfEditing();
            }else{
              addBook();
            }
            setState(() {

              textFieldvisibility = false;

               questionController.text = "";
               optionController1.text = "";
               optionController2.text = "";
               optionController3.text = "";
               optionController4.text = "";

               option1 = false;
               option2 = false;
               option3 = false;
               option4 = false;

            });
          },
        ),
      );
}

viewDialogBox(BuildContext context){
  showDialog(
                context: context,
                builder: (context) {
                  
                  return StatefulBuilder(builder: (context,setState){
                      return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          child:SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: questionController,
                                    decoration: InputDecoration(
                                    labelText: "Question",
                                    hintText:"Enter Question"
                              ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: optionController1,
                                  decoration: InputDecoration(
                                  labelText:"Option 1",
                                  hintText:"Enter Option 1"
                              ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CheckboxListTile(  
                                title: Text("Option 1 is Correct!"), //    <-- label
                                  value: this.option1,   
                                 onChanged: (bool value) {  
                               setState(() {  
                                this.option1 = value;   
                              });  
                               },  
                              ), 
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: optionController2,
                                  decoration: InputDecoration(
                                  labelText:"Option 2",
                                  hintText:"Enter Option 2"
                              ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CheckboxListTile(  
                                title: Text("Option 2 is Correct!"), //    <-- label
                                  value: this.option2,   
                                 onChanged: (bool value) {  
                               setState(() {  
                                this.option2 = value;   
                              });  
                               },  
                              ), 
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: optionController3,
                                  decoration: InputDecoration(
                                  labelText:"Option 3",
                                  hintText:"Enter Option 2"
                              ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CheckboxListTile(  
                                title: Text("Option 3 is Correct!"), //    <-- label
                                  value: this.option3,   
                                 onChanged: (bool value) {  
                               setState(() {  
                                this.option3 = value;   
                              });  
                               },  
                              ), 
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: optionController4,
                                  decoration: InputDecoration(
                                  labelText:"Option 4",
                                  hintText:"Enter Option 4"
                              ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CheckboxListTile(  
                                title: Text("Option 4 is Correct!"), //    <-- label
                                value: this.option4,   
                                 onChanged: (bool value) {  
                               setState(() {  
                                this.option4 = value;   
                              });  
                               },  
                              ), 
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                   child:Text(isEditing? "UPDATE" : "ADD"),
                                     onPressed: (){
                                      if(isEditing == true){
                                          updateIfEditing();
                                           }else{
                                            addBook();
                                          }
                                        Navigator.of(context).pop();
                                        setState(() {

                                          textFieldvisibility = false;

                                          questionController.text = "";
                                          optionController1.text = "";
                                          optionController2.text = "";
                                          optionController3.text = "";
                                          optionController4.text = "";

                                          option1 = false;
                                          option2 = false;
                                          option3 = false;
                                          option4 = false;

                                     });
                                    },
                                ),
                                 
                                  
                                ),
                              
                            ],
                          ),
                          ),
                        ),
                      ],
                    ),
                  );

                  });

                  });}
                 
              
      
   

Widget buildBody(BuildContext context){

    return StreamBuilder<QuerySnapshot>(
      stream: controller.getAllQuestions(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text('Error ${snapshot.error}');
        }
        if(snapshot.hasData){
          print("Document -> ${snapshot.data.docs.length}");
          return buildList(context,snapshot.data.docs);
        }
      },
    );
  }
Widget buildList(BuildContext context , List<DocumentSnapshot> snapshot){
    return ListView(
      children:snapshot.map((data) => listItemBuild(context,data)).toList(),
    );
  }

Widget listItemBuild(BuildContext context, DocumentSnapshot data) {

   final questionObj = Question.fromJson(data.data(),data.reference);

    return Padding(
      key: ValueKey(questionObj.question),
      padding: EdgeInsets.symmetric(vertical:19 , horizontal:1),
      child:Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(4),
        ),
        child: SingleChildScrollView(
          child: ListTile(
            title: Column(
              children: <Widget>[
                  Row(
                    children: <Widget>[
                        Icon(Icons.search_rounded,color:Colors.purple),
                        Text(questionObj.question),
                    ]
                  ),
                  Divider(),
                    Row(
                    children: <Widget>[
                        Icon(Icons.question_answer_rounded,color:Colors.orange),
                        Text(questionObj.options[0]),
                        if(questionObj.answerList[0]) Icon(Icons.check_circle_outline_rounded,color:Colors.green),
                       
                    ]
                  ),
                   Row(
                    children: <Widget>[
                        Icon(Icons.question_answer_rounded,color:Colors.orange),
                        Text(questionObj.options[1]),
                        if(questionObj.answerList[1]) Icon(Icons.check_circle_outline_rounded,color:Colors.green),
                        
                        

                    ]
                  ),
                   Row(
                    children: <Widget>[
                        Icon(Icons.question_answer_rounded,color:Colors.orange),
                        Text(questionObj.options[2]),
                        if(questionObj.answerList[2]) Icon(Icons.check_circle_outline_rounded,color:Colors.green),
                        
                    ]
                  ),
                   Row(
                    children: <Widget>[
                        Icon(Icons.question_answer_rounded,color:Colors.orange),
                        Text(questionObj.options[3]),
                        if(questionObj.answerList[3]) Icon(Icons.check_circle_outline_rounded,color:Colors.green),
                        
                    ]
                  ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color:Colors.red),
              onPressed: (){
                controller.deleteQuestion(questionObj);
                Fluttertoast.showToast(  
                msg: 'Selected Question has been deleted !',  
                toastLength: Toast.LENGTH_SHORT,  
                gravity: ToastGravity.BOTTOM,  
                timeInSecForIos: 1,  
                backgroundColor: Colors.white,  
                textColor: Colors.red  
    );  
              }),

              onTap: (){
                setUpdateUI(questionObj);
              },
          ),
        ),
      ),
    );

}

@override
Widget build(BuildContext context) {
     return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
         title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('img/Logo.png', fit: BoxFit.cover, height: 60.0,),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Guess The Word',
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 20.0
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children:<Widget> [
            Container(),
            SizedBox(
              height:20,
            ),
            Text("QUIZ LIST",style: TextStyle(
              fontSize:18,
              fontWeight:FontWeight.w800
            ),),
            SizedBox(
              height:20,
            ),
            Flexible(child: buildBody(context))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {viewDialogBox(context)},
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
        ),
   );
  }
}
