import 'package:flutter_dex/data/model/pokemon_moves.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pokemon_repository_provider.dart';

final pokemonMovesProvider =
    FutureProvider.family<List<List<PokemonMove>>, int>(
        (ref, id) => ref.read(pokemonRepositoryProvider).getPokemonMoves(id));
