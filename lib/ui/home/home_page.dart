import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dex/di/poke_api_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Material(
      child: IconButton(
        icon: Icon(Icons.download),
        onPressed: () {
          ref.read(pokeApiProvider).query('''
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
''', variables: {}).then((value) {
            final pokemon = Pokemon.fromBasicQuery(value.data!);
            pokemon.forEach((element) {
              print(element);
            });
          });
        },
      ),
    ));
  }
}
