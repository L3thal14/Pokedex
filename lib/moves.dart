import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Move extends StatefulWidget {
  final String url;
  final String imageurl;
  final String name;

  Move({Key key, @required this.url,this.imageurl,this.name}) : super(key: key);
  @override
  MoveState createState() => new MoveState(url,imageurl,name);
}

class MoveState extends State<Move> {
  final String url;
  final String imageurl;
  final String name;
  String searchString = "";
  MoveState(this.url,this.imageurl,this.name);
  List moves;
  int height;
  int weight;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
        Uri.encodeFull(url),
      headers: {"Accept": "application/json"}

    );

    setState(() {
      var toJsonData = json.decode(response.body);
      moves = toJsonData['moves'];
    });

    return "Success";
}

  @override
  Widget build(BuildContext context) {
        final deviceWidth = MediaQuery.of(context).size.height;
    return new Scaffold(
         backgroundColor: Colors.teal,
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Colors.teal,
          title: new Text("MOVES",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'RobotoMono',fontSize: 25,color: Colors.white ),
          ),
          centerTitle: true,
        ),
        body: new ListView.builder(
            itemCount: moves == null ? 0 : moves.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: new Center(
                      child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: deviceWidth * 0.5,
                  child: Card(
                    color: Colors.white,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
                      child: new Container(
                    child: new Text(capitalize(moves[index]['move']['name']).replaceAll('-', ' '),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Georgia',fontSize: 15,color: Colors.black ),
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                  elevation: 5,
    margin: EdgeInsets.all(15),
                ),
                  ),
                ],
              )));
            })
      
    );
  }
}
