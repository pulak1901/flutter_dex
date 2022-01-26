import 'package:flutter_dex/data/repository/pokemon_repository_impl.dart';
import 'package:flutter_dex/di/poke_api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonRepositoryProvider = Provider<PokemonRepositoryImpl>((ref) {
  return PokemonRepositoryImpl(client: ref.read(pokeApiProvider));
});
