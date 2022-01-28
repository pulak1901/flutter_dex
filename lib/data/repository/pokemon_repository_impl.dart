import 'package:flutter_dex/data/api/poke_api_client.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/data/model/pokemon_info.dart';
import 'package:flutter_dex/data/model/pokemon_moves.dart';
import 'package:flutter_dex/data/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiClient client;

  PokemonRepositoryImpl({required this.client});

  @override
  Future<List<Pokemon>> getAllPokemon() async {
    final result = await client.query('''
query basicPokemonQuery {
  pokemon_v2_pokemon(limit: 151, order_by: {id: asc}) {
    id
    name
    pokemon_v2_pokemontypes(where: {pokemon_v2_type: {generation_id: {_eq: 1}}}) {
      pokemon_v2_type {
        id
      }
    }
    pokemon_v2_pokemontypepasts(where: {pokemon_v2_type: {generation_id: {_eq: 1}}}) {
      pokemon_v2_type {
        id
      }
    }
  }
}
''', variables: {});

    return Pokemon.fromBasicQuery(result.data!);
  }

  @override
  Future<PokemonInfo> getPokemonInfo(int id) async {
    final result = await client.query('''
query pokemonInfoQuery {
  pokemon_v2_pokemon(where: {id: {_eq: $id}}) {
    height
    weight
    pokemon_v2_pokemonstats(where: {pokemon_id: {_eq: $id}}) {
      base_stat
      stat_id
      pokemon_v2_stat {
        name
      }
    }
  }
  pokemon_v2_pokemonspecies(where: {id: {_eq: $id}}) {
    gender_rate
    capture_rate
    pokemon_v2_pokemonspeciesnames(where: {language_id: {_eq: 9}}) {
      genus
    }
    pokemon_v2_pokemonspeciesflavortexts(where: {language_id: {_eq: 9}, version_id: {_eq: 1}}) {
      flavor_text
    }
  }
}
''', variables: {});

    return PokemonInfo.fromQuery(result.data!);
  }

  @override
  Future<List<PokemonMove>> getPokemonMoves(int id) async {
    final result = await client.query('''
query MyQuery {
  pokemon_v2_pokemonmove(order_by: {level: asc}, where: {pokemon_id: {_eq: $id}, pokemon_v2_versiongroup: {id: {_eq: 1}}}) {
    level
    pokemon_v2_move {
      name
      id
      power
      pp
      type_id
      accuracy
      pokemon_v2_machines(where: {pokemon_v2_versiongroup: {id: {_eq: 1}}}) {
        pokemon_v2_item {
          name
        }
      }
      pokemon_v2_movedamageclass {
        pokemon_v2_movedamageclassnames(where: {language_id: {_eq: 9}}) {
          name
        }
      }
      pokemon_v2_moveflavortexts(where: {version_group_id: {_eq: 3}}) {
        flavor_text
      }
    }
    pokemon_v2_movelearnmethod {
      name
    }
  }
}

''', variables: {});

    return PokemonMove.fromQuery(result.data!);
  }
}
