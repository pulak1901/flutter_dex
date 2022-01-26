import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pokemon_repository_provider.dart';

final pokemonProvider = FutureProvider(
    (ref) => ref.read(pokemonRepositoryProvider).getAllPokemon());
