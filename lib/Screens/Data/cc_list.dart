import 'dart:io';

import 'file:///C:/Users/yaroslav.shabatura/Downloads/flutter-cctracker/cctracker/lib/Screens/Data/cc_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList> {
  List<CCData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Awesome CC Tracker'),
        ),
        body: Container(child: ListView(children: _buildList())),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh), onPressed: () => _loadCC()));
  }

  @override
  void initState() {
    super.initState();
    _loadCC();
  }

  Widget alert() {
    return CupertinoAlertDialog(
        title: Text("you had long pressedon the ListTile" ),
        content: Text("yes or not"),
        actions: [
          CupertinoDialogAction(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pop(context);
              }),
          CupertinoDialogAction(child: Text("No"))
        ]);
  }

  List<Widget> _buildList() {
    return data
        .map((CCData f) => ListTile(
              title: Text(f.symbol),
              subtitle: Text(f.name),
              leading: CircleAvatar(child: Text(f.rank.toString())),
              trailing: Text('\$${f.price.toStringAsFixed(2)}'),
              onLongPress: () {
                showDialog(
                  context: context,
                  child: alert(),
                  barrierDismissible: false,
                );
              },
            ))
        .toList();
  }

  _loadCC() async {
    final response = await http
        .get('https://api.coincap.io/v2/assets?limit=10', headers: {
      HttpHeaders.authorizationHeader: "b85da77f-f1a0-4aa9-82bf-7821cca54275"
    });
    if (response.statusCode == 200) {
//      print(response.body);
      List<dynamic> allData =
          (json.decode(response.body) as Map<String, dynamic>)["data"];
      print('all data: $allData');
      var ccDataList = List<CCData>();
      for (var val in allData) {
        var record = CCData(
            name: val['name'],
            symbol: val['symbol'],
            rank: int.tryParse(val['rank'].toString()),
            price: double.tryParse(val['priceUsd'].toString()));

        ccDataList.add(record);
      }

      setState(() {
        data = ccDataList;
      });
    }
  }
}
