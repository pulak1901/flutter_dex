import 'package:flutter/material.dart';
import 'package:flutter_dex/di/pokemon_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Material(
      child: IconButton(
        icon: Icon(Icons.download),
        onPressed: () {
          ref
              .read(pokemonRepositoryProvider)
              .getAllPokemon()
              .then((value) => print(value));
        },
      ),
    ));
  }
}
