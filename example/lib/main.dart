import 'package:example/optionview.dart';
import 'package:example/type.dart';
import 'package:flutter/material.dart';

import 'p.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double op1 = 7.0;
  double op2 = 3.0;
  double op3 = 0.0;
  double op4 = 8.0;

  List<String> userWhoVoted = <String>[];
  String user = "SamuelEzedi";
  Map choiceData = {'MikeKing' : 3};
  String creator = "SamuelEzed";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            userWhoVoted.contains(this.user) ?
                Polls.viewPolls(
                  question: "Who said this in the bible \"I will show up and deal with them\"",
                  userChoice: choiceData[this.user],
                  children: [
                  PollOptions(title: 'Samuel',value: op1).show(),
                  PollOptions(title: 'Samuel 2',value: op2).show(),
                  PollOptions(title: 'Samuel 3',value: op3).show(),
                  PollOptions(title: 'Samuel 4',value: op4).show(),
                ],) :
                this.user == this.creator ?
                Polls.creator(
                  question: "Who said this in the bible \"I will show up and deal with them\"",
                  children: [
                    PollOptions(title: 'Samuel',value: 3.0).show(),
                    PollOptions(title: 'Samuel 2',value: 0.0).show(),
                    PollOptions(title: 'Samuel 3',value: 1.0).show(),
                  ],
                  voteEnds: DateTime(2020, 6,1,1,0,0,0,0),
                ) :
            Polls(
              question: "Who said this in the bible \"I will show up and deal with them\"",
                  children: [
                    PollOptions(title: 'Samuel',value: op1).show(),
                    PollOptions(title: 'Samuel 2',value: op2).show(),
                    PollOptions(title: 'Samuel 3',value: op3).show(),
                    PollOptions(title: 'Samuel 4',value: op4).show(),
                  ],
                  voteEnds: DateTime(2020, 6,1,1,0,0,0,0),
                  userChoice: 2,
                  onVote: (choice){
                    setState(() {
                      this.choiceData[this.user] = choice;
                      this.userWhoVoted.add(this.user);
                    });
                    if(choice ==1){
                      setState(() {
                        op1+= 1.0;

                      });
                    }
                    if(choice ==2){
                      setState(() {
                        op2+= 1.0;

                      });
                    }
                    if(choice ==3){
                      setState(() {
                        op3+= 1.0;
                      });
                    }
                    if(choice ==4){
                      setState(() {
                        op4+= 1.0;
                      });
                    }
                  },
                ),

          ],
        ),


      ),

    );
  }
}
