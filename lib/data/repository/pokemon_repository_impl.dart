import 'package:flutter_dex/data/api/poke_api_client.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/data/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiClient client;

  PokemonRepositoryImpl({required this.client});

  @override
  Future<List<Pokemon>> getAllPokemon() async {
    final result = await client.query('''
query basicPokemonQuery {
  pokemon_v2_pokemon(limit: 3, order_by: {id: asc}) {
    id
    name
    pokemon_v2_pokemontypes(where: {pokemon_v2_type: {generation_id: {_eq: 1}}}) {
      pokemon_v2_type {
        id
      }
    }
  }
}
''', variables: {});

    return Pokemon.fromBasicQuery(result.data!);
  }
}
