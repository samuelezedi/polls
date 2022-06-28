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
  String user = "king@mail.com";
  var usersWhoVoted = {
    'sam@mail.com': 3,
    'mike@mail.com': 4,
    'john@mail.com': 1,
    'kenny@mail.com': 1
  };

  PollController controller = PollController();

  List pollData = [
    {
      'question':
          'What\'s your favorite framework for building cross-platform mobile applications?',
      'options': <PollOption>[
        PollOption(option: 'Flutter', value: 213),
        PollOption(option: 'React', value: 25),
        PollOption(option: 'Xamarin', value: 2),
      ],
      'end_date': DateTime(2022, 8, 21),
    },
    {
      'question': 'What\'s the capital of USA?',
      'options': <PollOption>[
        PollOption(option: 'Washington DC', value: 55),
        PollOption(option: 'New York', value: 25),
        PollOption(option: 'Texas', value: 2),
        PollOption(option: 'London', value: 5),
      ],
      'end_date': DateTime(2022, 7, 23)
    },
    {
      'question': 'What\'s your stance on the anti abortion law?',
      'options': <PollOption>[
        PollOption(option: 'In Support', value: 1),
        PollOption(option: 'Not in support', value: 1),
        PollOption(option: 'Indifferent', value: 150),
      ],
      'end_date': DateTime(2022, 7, 1)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polls'),
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: ListView(
          children: pollData.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Polls(
                // viewType: PollType.voter,
                hasVoted: false,
                controller: controller,
                children: e['options'],
                barRadius: 5,
                question: Text(e['question']),
                userId: pollData.indexOf(e).toString(),
                onVoteBackgroundColor: Colors.blue,
                leadingBackgroundColor: Colors.blue,
                backgroundColor: Colors.white,
                getHighest: (val) {
                  print(val);
                },
                onVote: (pollOption, optionIndex, totalVotes) {
                  // setState(() {});
                  // print(this.usersWhoVoted);
                  // print(totalVotes);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

//
// class ExamplePolls extends StatefulWidget {
//   const ExamplePolls({Key? key}) : super(key: key);
//
//   @override
//   State<ExamplePolls> createState() => _ExamplePollsState();
// }
//
// class _ExamplePollsState extends State<ExamplePolls> {
//   List polls() => [
//     {
//       'id': 1,
//       'question':
//       'Is Flutter the best framework for building cross-platform applications?',
//       'end_date': DateTime(2022, 5, 21),
//       'options': [
//         {
//           'id': 1,
//           'title': 'Absolutely',
//           'votes': 40,
//         },
//         {
//           'id': 2,
//           'title': 'Maybe',
//           'votes': 20,
//         },
//         {
//           'id': 3,
//           'title': 'Meh!',
//           'votes': 10,
//         },
//       ],
//     },
//     {
//       'id': 2,
//       'question': 'Do you think Oranguntans have the ability speak?',
//       'end_date': DateTime(2022, 12, 25),
//       'options': [
//         {
//           'id': 1,
//           'title': 'Yes, they definitely do',
//           'votes': 40,
//         },
//         {
//           'id': 2,
//           'title': 'No, they do not',
//           'votes': 20,
//         },
//         {
//           'id': 3,
//           'title': 'I do not know',
//           'votes': 10,
//         },
//         {
//           'id': 4,
//           'title': 'Why should I care?',
//           'votes': 30,
//         }
//       ],
//     },
//     {
//       'id': 3,
//       'question':
//       'How do you know that your experience of consciousness is the same as other people’s experience of consciousness?',
//       'end_date': DateTime(2022, 09, 30),
//       'options': [
//         {
//           'id': 2,
//           'title': 'It is certain that they do',
//           'votes': 20,
//         },
//         {
//           'id': 3,
//           'title': 'How am I supposed to know?',
//           'votes': 10,
//         },
//       ],
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Flutter Polls 🗳')),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         padding: const EdgeInsets.all(20),
//         child: ListView.builder(
//           itemCount: polls().length,
//           itemBuilder: (BuildContext context, int index) {
//             final poll = polls()[index];
//
//             final days = DateTime(
//               poll['end_date'].year,
//               poll['end_date'].month,
//               poll['end_date'].day,
//             )
//                 .difference(DateTime(
//               DateTime.now().year,
//               DateTime.now().month,
//               DateTime.now().day,
//             ))
//                 .inDays;
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 20),
//               child: FlutterPolls(
//                 pollId: poll['id'].toString(),
//                 // hasVoted: hasVoted.value,
//                 // userVotedOptionId: userVotedOptionId.value,
//                 onVoted: (fp.PollOption pollOption, int newTotalVotes) {
//                   // hasVoted.value = true;
//                   // userVotedOptionId.value = pollOption.id;
//                 },
//                 pollEnded: days < 0,
//                 pollTitle: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     poll['question'],
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 pollOptions: poll['options'].map(
//                       (option) {
//                     return fp.PollOption(
//                       id: option['id'],
//                       title: Text(
//                         option['title'],
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       votes: option['votes'],
//                     );
//                   },
//                 ).toList(),
//                 votedPercentageTextStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 metaWidget: Row(
//                   children: [
//                     const SizedBox(width: 6),
//                     const Text(
//                       '•',
//                     ),
//                     const SizedBox(
//                       width: 6,
//                     ),
//                     Text(
//                       days < 0 ? "ended" : "ends $days days",
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
