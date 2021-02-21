import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/dets.dart';
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
            print("parsing & adding data");
            pokedexList.add(PokedexMdl.abilFromJson(dt));
            print("next!");
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
                      hintText: "Masukan nama lengkap/id pokemon",
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dets(
                                                det: pokedexList[index],
                                              )));
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
