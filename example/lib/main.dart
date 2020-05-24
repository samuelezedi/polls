
import 'dart:async';
import 'package:flutter/material.dart';
import 'polls.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Polls Example'),
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
  double option1 = 2.0;
  double option2 = 0.0;
  double option3 = 2.0;
  double option4 = 3.0;

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            children: <Widget>[

              ///Method One
              Text('Method 1', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
              Polls(
                question: Text('Which of these is the capital city of Egypt?'),
                viewType: usersWhoVoted.containsKey(this.user) ? PollsType.readOnly : this.user == this.creator ? PollsType.creator : PollsType.voter,
                children: [
                  PollOptions(title: 'Cairo', value: option1).show(),
                  PollOptions(title: 'Mecca', value: option2).show(),
                  PollOptions(title: 'Denmark', value: option3).show(),
                  PollOptions(title: 'Mogadishu', value: option4).show(),
                ],
                userChoice: usersWhoVoted[this.user],
                onVoteBackgroundColor: Colors.blue,
                leadingBackgroundColor: Colors.blue,
                backgroundColor: Colors.white,
                onVote: (choice) {

                  setState(() {
                    this.usersWhoVoted[this.user] = choice;
                  });
                  if (choice == 1) {
                    setState(() {
                      option1 += 1.0;
                    });
                  }
                  if (choice == 2) {
                    setState(() {
                      option2 += 1.0;
                    });
                  }
                  if (choice == 3) {
                    setState(() {
                      option3 += 1.0;
                    });
                  }
                  if (choice == 4) {
                    setState(() {
                      option4 += 1.0;
                    });
                  }
                },
              ),
              ///Method Two
              ///
//              Text('Method 2', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
//
//              Builder(
//                builder: (context) {
//                  if (usersWhoVoted2.containsKey(this.user2)) {
//                    return Polls.viewPolls(
//                      question: Text('What is the capital of Egypt?'),
//                      userChoice: usersWhoVoted2[this.user2],
//                      children: [
//                        PollOptions(title: 'Cairo', value: option1).show(),
//                        PollOptions(title: 'Mecca', value: option2).show(),
//                        PollOptions(title: 'Denmark', value: option3).show(),
//                        PollOptions(title: 'Mogadishu', value: option4).show(),
//                      ],
//                    );
//                  }
//
//                  if (this.user2 == this.creator) {
//                    return Polls.creator(
//                      question: Text('What is the capital of Egypt?'),
//                      leadingBackgroundColor: Colors.red,
//                      allowCreatorVote: true,
//                      children: [
//                        PollOptions(title: 'Samuel', value: 3.0).show(),
//                        PollOptions(title: 'Samuel 2', value: 0.0).show(),
//                        PollOptions(title: 'Samuel 3', value: 1.0).show(),
//                      ],
//                    );
//                  } else {
//                    return Polls.castVote(
//                      question: Text('What is the capital of Egypt?'),
//                      outlineColor: Colors.black54,
//                      children: [
//                        PollOptions(title: 'Samuel', value: option1).show(),
//                        PollOptions(title: 'Samuel 2', value: option2).show(),
//                        PollOptions(title: 'Samuel 3', value: option3).show(),
//                        PollOptions(title: 'Samuel 4', value: option4).show(),
//                      ],
//                      onVote: (choice) {
//                        print(choice);
//                        print(option2);
//
//                        setState(() {
//                          this.usersWhoVoted2[this.user2] = choice;
//                        });
//                        if (choice == 1) {
//                          setState(() {
//                            option1 += 1.0;
//                          });
//                        }
//                        if (choice == 2) {
//                          setState(() {
//                            option2 += 1.0;
//                          });
//                        }
//                        if (choice == 3) {
//                          setState(() {
//                            option3 += 1.0;
//                          });
//                        }
//                        if (choice == 4) {
//                          setState(() {
//                            option4 += 1.0;
//                          });
//                        }
//                      },
//                    );
//                  }
//                },
//              ),
//              SizedBox(
//                height: 20,
//              ),


            ],
          ),
        ),
      ),
    );
  }


}
