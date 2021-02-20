class PokedexMdl {
  int id;
  String name;
  int basexp;
  double height;
  double weight;
  String sprites;
  List<String> abilities;
  List<String> type;

  PokedexMdl(
      {this.id,
      this.name,
      this.basexp,
      this.height,
      this.weight,
      this.sprites,
      this.abilities,
      this.type});

  factory PokedexMdl.mainFromJson(Map<String, dynamic> json) {
    return PokedexMdl(
        id: json['id'],
        name: json['name'],
        basexp: json['base_experience'],
        height: double.parse(json["height"].toString()),
        weight: double.parse(json["weight"].toString()),
        sprites: json['sprites']['front_default']);
  }

  factory PokedexMdl.abilFromJson(Map<String, dynamic> json) {
    List<String> _aname = (json['abilities'] as List)
        .map((res) => res['ability']['name'].toString())
        .toList();
    List<String> _tipe = (json['types'] as List)
        .map((data) => data['type']['name'].toString())
        .toList();
    return PokedexMdl(
        id: json['id'],
        name: json['name'],
        basexp: json['base_experience'],
        height: double.parse(json["height"].toString()),
        weight: double.parse(json["weight"].toString()),
        sprites: json['sprites']['front_default'],
        abilities: _aname,
        type: _tipe);
  }
}
