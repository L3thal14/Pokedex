import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:pokedex/pokeinfo.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<void> _showInfoDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor: Colors.white,
          title: const Text('POKEDEX APP', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,fontFamily: 'Baloo',color: Colors.black,fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Text(' Developed by Karthik R', textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontFamily: 'Poppins',color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 20,
                ),
                Center(
                child: InkWell(
                  child: Text(
                    'Github',
                    style: TextStyle(
                      fontSize: 18,fontFamily: 'Poppins',color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () =>
                      launch('https://github.com/L3thal14'),
                ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK',style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final String url="https://pokeapi.co/api/v2/pokemon?limit=2000";
  String searchString = "";
  List data;
  String pokeurl;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String imageurl;
  String name;
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
      data = toJsonData['results'];
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
          title: new Text("POKEDEX ",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'RobotoMono',fontSize: 25,color: Colors.white ),
          ),
          centerTitle: true,
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          )
        ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
        Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.search,
                            color: Color(0xffca3e47),
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: TextField(
                        onChanged: (value) {
                          setState((){
                             searchString = value; 
                          });

                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),

                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
        Expanded(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return data[index]['name'].toLowerCase().contains(searchString.toLowerCase())? Container(
                    margin: EdgeInsets.all(8.0),
                      child: Card(
                         elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          child: InkWell(
                            onTap: () => {
                              pokeurl = '${data[index]['url']}',
                              imageurl = 'https://pokeres.bastionbot.org/images/pokemon/${index+1}.png',
                              name = '${data[index]['name']}',
                              print(pokeurl),
                              print(imageurl),
                               Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Pokeinfo(url: pokeurl,imageurl: imageurl,name: name,),
                  ),
            ),
                             
                            },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Container(
                              margin: const EdgeInsets.all(10),
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            fit: BoxFit.contain,
                            image: new NetworkImage(
                                'https://pokeres.bastionbot.org/images/pokemon/${index+1}.png'),
                        )
                    )),
                    SizedBox(width: 30),
                new Text(capitalize(data[index]['name']),
                    textScaleFactor: 1.5,style: TextStyle(fontFamily: 'Roboto'),)
                            
                          ],
                        ),
                          ),
                    ),
  
                  ): Container();
                },
                itemCount:data.length,
              );
            }
          },
          future: getJsonData(),
        ),
      ),

      ],) 
      
      
    );
  }
}
