class PokedexMdl {
  int id;
  String name;
  int basexp;
  double height;
  double weight;
  String sprites;

  PokedexMdl(
      {this.id,
      this.name,
      this.basexp,
      this.height,
      this.weight,
      this.sprites});

  factory PokedexMdl.fromJson(Map<String, dynamic> json) {
    return PokedexMdl(
        id: json['id'],
        name: json['name'],
        basexp: json['base_experience'],
        height: double.parse(json["height"].toString()),
        weight: double.parse(json["weight"].toString()),
        sprites: json['sprites']['front_default']);
  }
}
