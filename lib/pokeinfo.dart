import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/abilities.dart';
import 'package:pokedex/moves.dart';
import 'dart:convert';
import 'package:pokedex/types.dart';

class Pokeinfo extends StatefulWidget {
  final String url;
  final String imageurl;
  final String name;

  Pokeinfo({Key key, @required this.url,this.imageurl,this.name}) : super(key: key);
  @override
  PokeinfoState createState() => new PokeinfoState(url,imageurl,name);
}

class PokeinfoState extends State<Pokeinfo> {
  final String url;
  final String imageurl;
  final String name;
  String searchString = "";
  PokeinfoState(this.url,this.imageurl,this.name);
  List abilities;
  List moves;
  List types;
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
      height = toJsonData['height'];
      weight = toJsonData['weight'];
      abilities = toJsonData['abilities'];
      moves = toJsonData['moves'];
      types = toJsonData['types'];
    });

    return "Success";
}

  @override
  Widget build(BuildContext context) {
        final deviceWidth = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: AppBar(
        
//        backgroundColor: Colors.transparent,
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(name.toUpperCase()),
        centerTitle: true,
      ),
         backgroundColor: Colors.teal,
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else { 
              return Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                  ),
                  Text(
                    capitalize(name),
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text("Height: ${(height/10)} m"),
                  Text("Weight: ${weight} gms"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                    "Moves",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 2.0, bottom: 2.0, right: 20.0, left: 7.0),
                            onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Move(url: url,imageurl: imageurl,name: name,)),
  );
},
 
                   

                                child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: new Text(
                                      "See More",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto'),
                                    )),
                            textColor: Colors.white,
                            color: Colors.red),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        width: 110,
                        height: 25,
                        child: Center(child: Text(capitalize('${moves[0]['move']['name']}'.replaceAll('-', ' '))),
                        ),
                      ),
                      Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        width: 110,
                        height: 25,
                        child: Center(child: Text(capitalize('${moves[1]['move']['name']}'.replaceAll('-', ' '))),
                        ),
                      ),
                       Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        width: 110,
                        height: 25,
                        child: Center(child: Text(capitalize('${moves[2]['move']['name']}'.replaceAll('-', ' '))),
                        ),
                      ),
                    ],
                  ), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                    "Abilities",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                      RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 2.0, bottom: 2.0, right: 20.0, left: 7.0),
                            onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Ability(url: url,imageurl: imageurl,name: name,)),
  );
},
 
                   

                                child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: new Text(
                                      "See More",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto'),
                                    )),
                            textColor: Colors.white,
                            color: Colors.red),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        width: 120,
                        height: 25,
                        child: Center(child: Text(capitalize('${abilities[0]['ability']['name']}'.replaceAll('-', ' '))),
                        ),
                      ),
                      Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        width: 120,
                        height: 25,
                        child: Center(child: Text(capitalize('${abilities[1]['ability']['name']}'.replaceAll('-', ' '))),
                        ),
                      ),
                    ],
                  ), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                                        Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                      RaisedButton(
                            elevation: 0.0,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 2.0, bottom: 2.0, right: 20.0, left: 7.0),
                            onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Typepoke(url: url,imageurl: imageurl,name: name,)),
  );
},
 
                   

                                child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: new Text(
                                      "See More",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto'),
                                    )),
                            textColor: Colors.white,
                            color: Colors.red),
                    ],
                  ),
         
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        width: 60,
                        height: 25,
                        child: Center(child: Text(capitalize('${types[0]['type']['name']}'.replaceAll('-', ' '))),
                        ),
                      ),
                      (types.length > 1)?
                       Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        width: 60,
                        height: 25,
                        child: Center(child: Text(capitalize('${types[1]['type']['name']}'.replaceAll('-', ' '))),
                        ),
                      ) : Container(),
                  
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: imageurl,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(imageurl))),
                )),
          )
        ],
      );
            
            }
          },future: getJsonData())
      
    );
  }
}
