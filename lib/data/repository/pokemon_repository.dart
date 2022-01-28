import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/data/model/pokemon_info.dart';
import 'package:flutter_dex/data/model/pokemon_moves.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getAllPokemon();

  Future<PokemonInfo> getPokemonInfo(int id);

  Future<List<List<PokemonMove>>> getPokemonMoves(int id);
}
