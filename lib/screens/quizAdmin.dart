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

bool option1 = false;
bool option2 = false;
bool option3 = false;
bool option4 = false;


bool isEditing = false;
bool textFieldvisibility = false; 

String firestoreCollectionName = "test";

Question currentQuestion;

getAllQuestions(){
    return FirebaseFirestore.instance.collection(firestoreCollectionName).snapshots();
}

getNumberOfQuestions(){
    
}

addBook() async{

    List<String> optionsList = [optionController1.text, optionController2.text, optionController3.text, optionController4.text];
    List<bool> answerList = [option1,option2,option3,option4];

    Question question = Question(question: questionController.text,options: optionsList,answerList: answerList);

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

updateQuestion(Question questionObj,String question,List<String> optionsList,List<bool> answerList){
    try{

      FirebaseFirestore.instance.runTransaction((transaction) async {

        await transaction.update(questionObj.id, {'question': question,'options': optionsList,'answerList': answerList});
      });

    }catch(e){
        print(e.toString());
    }
  }

  updateIfEditing(){

    
    List<String> newOptionsList = [optionController1.text, optionController2.text, optionController3.text, optionController4.text];
    List<bool> newAnswerList = [option1,option2,option3,option4];

    if(isEditing){

        updateQuestion(currentQuestion,questionController.text,newOptionsList,newAnswerList);

      setState(() {
        isEditing = false;
      });
    }
  }

  deleteQuestion(Question question){

      FirebaseFirestore.instance.runTransaction(
        (Transaction transaction) async{
            await transaction.delete(question.id);

        });
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
                  CheckboxListTile(  
                  title: Text("Option 1 is a Correct word"), //    <-- label
                  value: this.option1,   
                  onChanged: (bool value) {  
                    setState(() {  
                        this.option1 = value;   
                      });  
                    },  
                  ), 
                 
                 TextFormField(
                   controller: optionController2,
                   decoration: InputDecoration(
                     labelText:"Option 2",
                     hintText:"Enter Option 2"
                   ),
                   
                 ),
                CheckboxListTile(  
                  title: Text("Option 2 is a Correct word"), //    <-- label
                  value: this.option2,   
                  onChanged: (bool value) {  
                    setState(() {  
                        this.option2 = value;   
                      });  
                    },  
                  ),  
                 TextFormField(
                   controller: optionController3,
                   decoration: InputDecoration(
                     labelText:"Option 3",
                     hintText:"Enter Option 3"
                   ),
                 ),
                   CheckboxListTile(  
                  title: Text("Option 3 is a Correct word"), //    <-- label
                  value: this.option3,   
                  onChanged: (bool value) {  
                    setState(() {  
                        this.option3 = value;   
                      });  
                    },  
                  ),
                 
                 TextFormField(
                   controller: optionController4,
                   decoration: InputDecoration(
                     labelText:"Option 4",
                     hintText:"Enter Option 4"
                   ),
                 ),
                   CheckboxListTile(  
                  title: Text("Option 4 is a Correct word"), //    <-- label
                  value: this.option4,   
                  onChanged: (bool value) {  
                    setState(() {  
                        this.option4 = value;   
                      });  
                    },  
                  ),  
                   ],),
              
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
