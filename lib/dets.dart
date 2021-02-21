import 'package:flutter/material.dart';
import 'package:pokedex/engine/pokedex_mdl.dart';

class Dets extends StatelessWidget {
  final PokedexMdl det;

  const Dets({Key key, @required this.det}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(det.name),
        ),
        body: Column(
          children: [
            Container(
              child: Center(
                child: Image(
                  image: NetworkImage(det.sprites, scale: 0.5),
                ),
              ),
            ),
            Container(
              child: Text(
                "ID : #${det.id}",
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              child: Text(
                "Name : ${det.name}",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              child: Text(
                "Height : ${det.height} decimeter",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              child: Text(
                "Weight : ${det.weight} hectograms",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        "Abilities : ",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      width: 220,
                      height: 220,
                      child: ListView.builder(
                        itemCount: det.abilities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                child: Text(
                                  "${index + 1}. ${det.abilities[index]}",
                                  style: TextStyle(fontSize: 25),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        "Type : ",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 100,
                      height: 220,
                      child: ListView.builder(
                          itemCount: det.type.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Container(
                                  child: Text(
                                    "${det.type[index]}",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
