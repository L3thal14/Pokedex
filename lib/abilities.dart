import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Ability extends StatefulWidget {
  final String url;
  final String imageurl;
  final String name;

  Ability({Key key, @required this.url,this.imageurl,this.name}) : super(key: key);
  @override
  AbilityState createState() => new AbilityState(url,imageurl,name);
}

class AbilityState extends State<Ability> {
  final String url;
  final String imageurl;
  final String name;
  String searchString = "";
  AbilityState(this.url,this.imageurl,this.name);
  List abilities;
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
      abilities = toJsonData['abilities'];
    });

    return "Success";
}

  @override
  Widget build(BuildContext context) {
        final deviceWidth = MediaQuery.of(context).size.height;
    return new Scaffold(
         backgroundColor: Colors.teal,
        appBar: new AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: new Text("ABILITIES",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'RobotoMono',fontSize: 25,color: Colors.white ),
          ),
          centerTitle: true,
        ),
        body: new ListView.builder(
            itemCount: abilities == null ? 0 : abilities.length,
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
                    child: new Text(capitalize(abilities[index]['ability']['name']).replaceAll('-', ' '),
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
