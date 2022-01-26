import 'package:flutter_dex/data/model/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getAllPokemon();
}
