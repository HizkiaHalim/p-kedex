import 'package:pokedex/engine/ApiUrl.dart';
import 'package:dio/dio.dart';

class Pokedexsrvc {
  static Future fetchPokemon(String id) async {
    Dio dio = new Dio();
    var response = await dio.get(ApiUrl.apislashpokemon + "/${id}",
        options: Options(headers: {"Accept": "application/json"}));
    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 200) {
      return null;
    }
  }
}
