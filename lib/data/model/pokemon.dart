import 'package:flutter_dex/data/model/types.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Pokemon {
  int id;
  String name;
  List<PokemonType> types;

  Pokemon({required this.id, required this.name, required this.types});

  static List<Pokemon> fromBasicQuery(Map<String, dynamic> data) {
    List<dynamic> d = data["pokemon_v2_pokemon"];

    List<Pokemon> pokemon = [];
    for (int i = 0; i < d.length; i++) {
      Map<String, dynamic> p = d[i];

      int _id = p["id"];
      String _name = p["name"];

      List<dynamic> t = p["pokemon_v2_pokemontypes"];
      List<PokemonType> _types = [];
      for (int j = 0; j < t.length; j++) {
        Map<String, dynamic> t1 = t[j];
        Map<String, dynamic> t2 = t1["pokemon_v2_type"];
        int t3 = t2["id"];

        _types.add(PokemonType.values[t3]);
      }

      pokemon.add(Pokemon(id: _id, name: _name.capitalize(), types: _types));
    }

    return pokemon;
  }

  @override
  String toString() {
    String type = "(";
    types.getRange(0, types.length - 1).forEach((element) {
      type = type + element.name.capitalize() + ", ";
    });
    type = type + types.last.name.capitalize() + ")";

    return id.toString() + " " + name + " " + type;
  }
}
