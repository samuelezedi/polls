
import 'package:flutter/material.dart';

class PollWidget {

  String c1;
  String c2;
  String c3;
  String c4;
  double v1;
  double v2;
  double v3;
  double v4;
  int total;
  double highest;

  PollWidget.instance({c1, c2, c3, c4, v1, v2, v3, v4,total, highest}) {
    this.c1 = c1;
    this.c2 = c2;
    this.c3 = c3;
    this.c4 = c4;
    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
    this.v4 = v4;
    this.highest = highest;
    this.total = total;
  }

  voteCasted(context) {
    print(c3);

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(this.c1,
                  style: TextStyle(fontSize: 18.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(this.c2,
                  style: TextStyle(fontSize: 18.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(this.c3,
                  style: TextStyle(fontSize: 18.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              onPressed: () {
                //cast vote
//              _calculateVoteAndPost(data, 1, 'one');
              },
              color: Colors.green,
              padding: EdgeInsets.all(5.0),
              child: Text(this.c4,
                  style: TextStyle(fontSize: 18.0)),
              borderSide: BorderSide(
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
//                              side: BorderSide(color: Colors.red)
              ),
            ),
          ),
        ),
      ],
    );
  }

}