
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';



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
      home: PollView(),
    );
  }
}


class PollView extends StatefulWidget {
  @override
  _PollViewState createState() => _PollViewState();
}

class _PollViewState extends State<PollView> {

  double option1 = 3.0;
  double option2 = 0.0;
  double option3 = 1.0;
  double option4 = 1.0;
  double option5 = 1.0;
  double option6 = 3.0;
  double option7 = 2.0;
  double option8 = 1.0;

  String user = "king@mail.com";
  var usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Polls Refactor'),),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
        child: Polls(
          viewType: PollsType.readOnly,
          children: [
            // This cannot be less than 2, else will throw an exception
            PollOption(option: '21', value: option1),
            PollOption(option: '29', value: option2),
            PollOption(option: '40', value: option3),
            PollOption(option: '11', value: option4),
          ],
          barRadius: 15,
          question: Text('How old am I?'),
          currentUser: this.user,
          creatorID: this.creator,
          voteData: usersWhoVoted,
          userChoice: usersWhoVoted[this.user],
          onVoteBackgroundColor: Colors.blue,
          leadingBackgroundColor: Colors.blue,
          backgroundColor: Colors.white,
          onVote: (choice) {
            print(choice);
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
            if (choice == 5) {
              setState(() {
                option5 += 1.0;
              });
            }
            if (choice == 6) {
              setState(() {
                option6 += 1.0;
              });
            }
            if (choice == 7) {
              setState(() {
                option7 += 1.0;
              });
            }
            if (choice == 8) {
              setState(() {
                option8 += 1.0;
              });
            }
          },
        ),
      ),
    );
  }
}
