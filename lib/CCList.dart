import 'dart:io';

import 'package:cctracker/CCData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList>{
  List<CCData> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awesome CC Tracker'),
      ),
      body: Container(
        child: ListView(
            children: _buildList()
        )
      ),
            floatingActionButton: FloatingActionButton(
    child: Icon(Icons.refresh),
    onPressed: () => _loadCC()
    )
    );
  }
  List<Widget> _buildList(){
    return data.map((CCData f ) => ListTile(
        title: Text(f.symbol),
        subtitle: Text(f.name),
        leading: CircleAvatar(child: Text(f.rank.toString())),
        trailing: Text('\$${f.price.toString()}')
    )).toList();
  }
  _loadCC() async{
    final response = await http.get('https://api.coincap.io/v2/assets?limit=10', headers: {HttpHeaders.authorizationHeader: "b85da77f-f1a0-4aa9-82bf-7821cca54275"});
    if(response.statusCode == 200){
      print(response.body);
      var allData = (json.decode(response.body) as Map)['data'] as Map<String, dynamic>;
      var ccDataList = List<CCData>();
      allData.forEach((String key, dynamic val){
        var record = CCData(name:val['name'], symbol:val['symbol'], rank:val['rank']);
        ccDataList.add(record);
      });

      setState(() {
        data = ccDataList;
      });
      print(data);
    }
  
}
}