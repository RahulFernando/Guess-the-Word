import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/question.dart';


class QuizAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: QuizAdminDemo(),
    );
  }
}

class QuizAdminDemo extends StatefulWidget {
   QuizAdminDemo() : super();

  final String appTitle = "Quiz DB";
  @override
  _QuizAdminDemoState createState() => _QuizAdminDemoState();
}

class _QuizAdminDemoState extends State<QuizAdminDemo> {
TextEditingController questionController = TextEditingController();
TextEditingController optionController1 = TextEditingController();
TextEditingController optionController2 = TextEditingController();
TextEditingController optionController3 = TextEditingController();
TextEditingController optionController4 = TextEditingController();

bool isEditing = false;
bool textFieldvisibility = false; 

String firestoreCollectionName = "test";

Question currentQuestion;

getAllQuestions(){
    return FirebaseFirestore.instance.collection(firestoreCollectionName).snapshots();
}

addBook() async{
    Question question = Question(question: questionController.text,option1: optionController1.text,option2: optionController2.text,option3: optionController3.text,option4: optionController4.text);

    try{

      FirebaseFirestore.instance.runTransaction(
        (Transaction transaction) async{
            await FirebaseFirestore.instance
                            .collection(firestoreCollectionName)
                            .doc()
                            .set(question.toMap());

        }
      );
    }catch(e){
        print(e.toString());
    }
  }

updateQuestion(Question questionObj , String question , String answer){
    
  }

  updateIfEditing(){

    if(isEditing){

      setState(() {
        isEditing = false;
      });
    }
  }

  deleteQuestion(Question question){

  }


Widget buildBody(BuildContext context){

    return StreamBuilder<QuerySnapshot>(
      stream: getAllQuestions(),
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

    final questionObj = Question.fromJson(data.data());

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
                        Icon(Icons.question_answer,color:Colors.yellow),
                        Text(questionObj.question)
                    ]
                  ),
                  Divider(),
                    Row(
                    children: <Widget>[
                        Icon(Icons.person,color:Colors.purple),
                        Text(questionObj.option1)
                    ]
                  ),
                   Row(
                    children: <Widget>[
                        Icon(Icons.person,color:Colors.purple),
                        Text(questionObj.option2)
                    ]
                  ),
                   Row(
                    children: <Widget>[
                        Icon(Icons.person,color:Colors.purple),
                        Text(questionObj.option3)
                    ]
                  ),
                   Row(
                    children: <Widget>[
                        Icon(Icons.person,color:Colors.purple),
                        Text(questionObj.option4)
                    ]
                  ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color:Colors.red),
              onPressed: (){
                deleteQuestion(questionObj);
              }),

              onTap: (){
                setUpdateUI(questionObj);
              },
          ),
        ),
      ),
    );

  }

setUpdateUI(Question questionObj){
      questionController.text = questionObj.question;
      optionController1.text = questionObj.option1;
      optionController2.text = questionObj.option2;
      optionController3.text = questionObj.option3;
      optionController4.text = questionObj.option4;

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
            });
          },
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
          actions:<Widget>[
          IconButton(
            icon:Icon(Icons.add),
            onPressed:(){
              setState(() {
                textFieldvisibility = !textFieldvisibility;
              });
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children:<Widget> [
            textFieldvisibility ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
               children:<Widget> [
                 Column(
                   children: [
                     TextFormField(
                       controller: questionController,
                       decoration: InputDecoration(
                         labelText: "Question",
                         hintText:"Enter Question"
                       ),
                     ),
                      TextFormField(
                   controller: optionController1,
                   decoration: InputDecoration(
                     labelText:"Option 1",
                     hintText:"Enter Option 1"
                   ),
                 ),
                 TextFormField(
                   controller: optionController2,
                   decoration: InputDecoration(
                     labelText:"Option 2",
                     hintText:"Enter Option 2"
                   ),
                 ),
                 TextFormField(
                   controller: optionController3,
                   decoration: InputDecoration(
                     labelText:"Option 3",
                     hintText:"Enter Option 3"
                   ),
                 ),
                 TextFormField(
                   controller: optionController4,
                   decoration: InputDecoration(
                     labelText:"Option 4",
                     hintText:"Enter Option 4"
                   ),
                 ),
                   ],
                 ),
                SizedBox(
               height: 10,
            ),
            button()
               ],
            ):Container(),
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
            Flexible(child: buildBody(context),)
          ],
        ),
        

      ),
    );
  }
}
