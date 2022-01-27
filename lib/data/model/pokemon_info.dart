import 'package:flutter_dex/utility/string_extension.dart';
import 'package:units_converter/properties/length.dart';
import 'package:units_converter/properties/mass.dart';

class PokemonInfo {
  final Length height;
  final Mass weight;
  final Map<String, int> baseStats;
  final int genderRate;
  final int captureRate;
  final String species;
  final String entry;

  PokemonInfo(
      {required this.height,
      required this.weight,
      required this.baseStats,
      required this.genderRate,
      required this.captureRate,
      required this.species,
      required this.entry});

  static PokemonInfo fromQuery(Map<String, dynamic> data) {
    List<dynamic> d = data["pokemon_v2_pokemon"];

    Map<String, dynamic> details = d[0];
    int h = details["height"] * 10; // convert from decimeter to cm
    int w = details["weight"] * 100; // convert from hectogram to gm

    List<dynamic> st = details["pokemon_v2_pokemonstats"];
    Map<String, int> stats = {};
    for (int i = 0; i < st.length; i++) {
      Map<String, dynamic> st1 = st[i];
      Map<String, dynamic> st2 = st1["pokemon_v2_stat"];

      String stname = st2["name"];
      stname = stname.split('-').map((e) => e.capitalize()).join(" ");
      if (stname == 'Hp') {
        stname = stname.toUpperCase();
      }
      stats[stname] = st1["base_stat"];
    }

    List<dynamic> d2 = data["pokemon_v2_pokemonspecies"];
    Map<String, dynamic> speciesdetails = d2[0];
    int g = speciesdetails["gender_rate"];
    int c = speciesdetails["capture_rate"];

    List<dynamic> d21 = speciesdetails["pokemon_v2_pokemonspeciesnames"];
    Map<String, dynamic> genusdetails = d21[0];
    String t = genusdetails["genus"];

    List<dynamic> d22 = speciesdetails["pokemon_v2_pokemonspeciesflavortexts"];
    Map<String, dynamic> textdetails = d22[0];
    String f = textdetails["flavor_text"];

    return PokemonInfo(
        height: Length()..convert(LENGTH.centimeters, h.toDouble()),
        weight: Mass()..convert(MASS.grams, w.toDouble()),
        baseStats: stats,
        genderRate: g,
        captureRate: c,
        species: t,
        entry: f.replaceAll('\n', ' ').replaceAll('\f', ' '));
  }
}
