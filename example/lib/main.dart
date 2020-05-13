import 'package:example/pollcontroller.dart';
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  onVote(d){
    print(d);
    return true;
  }

  @override
  Widget build(BuildContext context) {

    PollsController controller;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          children: <Widget>[
            Polls(
                  children: [
                    Options(option: 1,title: 'Samuel',value: 2.0,),
                    Options(option: 2,title: 'Samuel 2',value: 0.0),
                    Options(option: 3,title: 'Samuel 3',value: 0.0,),
                    Options(option: 4,title: 'Samuel 4',value: 0.0,),
                  ],
                  totalVotes: 2,
                  voteEnds: DateTime(2020, 6,1,1,0,0,0,0),
                  pollData: {'kenny':1,'shade':2},
                  type: Type.CREATOR,
                  onVote: (id, value){
                    print(id);
                    print(value);
                  },
                ),


            Polls(
              children: [
                Options(option: 1,title: 'Samuel',value: 3.0,),
                Options(option: 2,title: 'Samuel 2',value: 0.0),
                Options(option: 3,title: 'Samuel 3',value: 1.0,),
                Options(option: 4,title: 'Samuel 4',value: 0.0,),
              ],
              totalVotes: 2,
              voteEnds: DateTime(2020, 6,1,1,0,0,0,0),
              pollData: {'kenny':1,'shade':2},
              type: Type.CREATOR,
              onVote: (id, value){
                print(id);
                print(value);
              },
            ),
          ],
        ),


      ),

    );
  }
}
