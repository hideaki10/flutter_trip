import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calculate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalculateState();
  }
}


class _CalculateState extends State<Calculate> {
  String countString = "";
  String localCount = "";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Http"),
        ),
        // weidget →　FutureBuilder
        body:Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _IncrementCount,
              child: Text("Increment Conut"),
            ),
            RaisedButton(
              onPressed: _GetCount,
              child: Text("get Conut"),
            ),
            Text(
              countString,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              localCount,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  _IncrementCount() async {
    SharedPreferences prefts = await SharedPreferences.getInstance();
    setState(() {
      countString = countString + "1";
    });

    int counter = (prefts.getInt("counter") ?? 0) + 1;
    await prefts.setInt("counter", counter);
  }

  _GetCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      localCount = prefs.getInt("counter").toString();
    });
  }
}