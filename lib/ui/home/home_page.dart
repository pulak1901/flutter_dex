import 'package:flutter/material.dart';
import 'package:flutter_dex/data/model/pokemon.dart';
import 'package:flutter_dex/ui/widgets/pokemon_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dex/di/pokemon_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Material(child: PokemonList()),
    );
  }
}

class PokemonList extends ConsumerWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Pokemon>> pm = ref.watch(pokemonProvider);

    return pm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text("Error! $err"),
        data: (pokemon) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: pokemon.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) =>
                    PokemonTile(pokemon: pokemon[index]),
              ),
            ));
  }
}
