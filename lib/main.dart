import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/engine/pokedex_srvc.dart';
import 'package:pokedex/engine/pokedex_mdl.dart';
import 'package:pokedex/searchres.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "P@kedex",
      theme: new ThemeData(primaryColor: Colors.red),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<PokedexMdl> pokedexList;
  List<PokedexMdl> get getPokedex => pokedexList;
  bool isSearching = false;
  int id = 0;
  String qry;
  getPokemon() async {
    if (pokedexList == null) {
      pokedexList = new List<PokedexMdl>();
    }
    if (id < 152) {
      for (var i = 0; i < 152; i++) {
        id++;
        print("pulling data from id ${id.toString()}");
        var dt = await Pokedexsrvc.fetchPokemon(id.toString());
        if (dt != null) {
          setState(() {
            pokedexList.add(PokedexMdl.fromJson(dt));
          });
        }
      }
    }
    print(pokedexList.length);
    return pokedexList;
  }

  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image(
            image: AssetImage('images/pokeball.png'),
          ),
          title: !isSearching
              ? Text("P@kedex")
              : TextField(
                  style: TextStyle(color: Colors.white),
                  onSubmitted: (value) {
                    setState(() {
                      qry = value;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Searchres(query: qry)));
                    });
                  },
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "Search Pokemon Name or ID Here",
                      hintStyle: TextStyle(color: Colors.white))),
          actions: <Widget>[
            isSearching
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    })
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    },
                  )
          ],
        ),
        body: Container(
            child: pokedexList.length > 0
                ? ListView.builder(
                    itemCount: pokedexList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      child: new AlertDialog(
                                        title: new Text(
                                            "#${pokedexList[index].id}   ${pokedexList[index].name}"),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Image(
                                                image: NetworkImage(
                                                    pokedexList[index].sprites,
                                                    scale: 0.5),
                                              ),
                                              Text(
                                                'id : #${pokedexList[index].id}',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                'height : ${pokedexList[index].height} decimeters',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                'weight : ${pokedexList[index].weight} hectograms',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                'Base exp : ${pokedexList[index].basexp}',
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              child: Text(
                                                'Back',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              })
                                        ],
                                      ));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        pokedexList[index].sprites,
                                        scale: 0.6),
                                    backgroundColor: Colors.red,
                                    radius: 50,
                                  ),
                                  title: Text(
                                    "#${pokedexList[index].id} ${pokedexList[index].name}",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    })
                : Container(
                    child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ))));
  }
}
