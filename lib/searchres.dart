import 'package:flutter/material.dart';
import 'package:pokedex/dets.dart';
import 'package:pokedex/engine/pokedex_mdl.dart';
import 'package:pokedex/engine/pokedex_srvc.dart';

class Searchres extends StatefulWidget {
  final String query;
  Searchres({Key key, @required this.query}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Searchres> {
  List<PokedexMdl> searchList;

  getSearch() async {
    if (searchList == null) {
      searchList = new List<PokedexMdl>();
    }
    print("pull searchList");
    var dt = await Pokedexsrvc.fetchPokemon(widget.query.toString());
    if (dt != null) {
      setState(() {
        searchList.add(PokedexMdl.abilFromJson(dt));
      });
    }
    print(searchList.length);
    return searchList;
  }

  @override
  void initState() {
    super.initState();
    getSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hasil"),
        ),
        body: Container(
            child: searchList.length > 0
                ? ListView.builder(
                    itemCount: searchList.length,
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
                                                det: searchList[index],
                                              )));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        searchList[index].sprites,
                                        scale: 0.6),
                                    backgroundColor: Colors.red,
                                    radius: 50,
                                  ),
                                  title: Text(
                                    "#${searchList[index].id} ${searchList[index].name}",
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
